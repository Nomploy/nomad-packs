#!/usr/bin/env bash
# Smoke-tests packs: renders each with nomad-pack, runs the job against a reachable
# Nomad agent (docker driver required), waits for the allocation to come up and
# stay running, then does a best-effort HTTP probe of the primary port.
#
# This is a stronger signal than `nomad job validate`: it proves the pack's image
# actually pulls and boots. It is intentionally lenient — any HTTP response
# (including 401/403) counts as "listening", and the probe is non-fatal; the hard
# requirement is that the allocation reaches and holds "running" without
# crash-looping.
#
# Usage:
#   scripts/smoke-test.sh <pack-id> [pack-id ...]   # explicit list
#   scripts/smoke-test.sh                            # auto-detect from git diff
#
# Env:
#   NOMAD_ADDR      Nomad agent address (default http://127.0.0.1:4646)
#   BASE_REF        git ref to diff against for auto-detection (default origin/master)
#   SETTLE_SECONDS  how long the alloc must stay running (default 45)
#   BOOT_TIMEOUT    max seconds to wait for the alloc to reach running (default 150)
set -uo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
export NOMAD_ADDR="${NOMAD_ADDR:-http://127.0.0.1:4646}"
SETTLE_SECONDS="${SETTLE_SECONDS:-45}"
BOOT_TIMEOUT="${BOOT_TIMEOUT:-150}"
tmp="$(mktemp -d)"
fail=0

# When HEALTH_OUT is set, append a "<id>\t<status>\t<detail>" line per pack
# (status = pass | failed | skipped) so a later step can publish a health badge.
HEALTH_OUT="${HEALTH_OUT:-}"
record() { [ -n "$HEALTH_OUT" ] && printf '%s\t%s\t%s\n' "$1" "$2" "${3:-}" >>"$HEALTH_OUT"; return 0; }

# Packs that cannot boot healthily in a bare CI dev agent (need real hardware,
# a specific host NIC/USB device, a public IP, or external state). Skipped with a
# printed reason rather than failed.
declare -A SKIP=(
  [scrutiny]="needs block devices (/dev/sd*)"
  [makemkv]="needs an optical drive / device passthrough"
  [ntopng]="needs a real capture interface (-i)"
  [netalertx]="needs raw-socket LAN scanning on a real interface"
  [zwave-js-ui]="needs a Z-Wave USB dongle"
  [handbrake]="GUI/transcode image, no HTTP healthcheck worth gating"
)

if ! command -v nomad-pack >/dev/null 2>&1; then echo "nomad-pack not in PATH" >&2; exit 2; fi
if ! command -v nomad >/dev/null 2>&1; then echo "nomad not in PATH" >&2; exit 2; fi

# Resolve the list of pack ids to test.
ids=("$@")
if [ "${#ids[@]}" -eq 0 ]; then
  base="${BASE_REF:-origin/master}"
  echo "No ids given; detecting changed packs vs $base"
  mapfile -t ids < <(git -C "$root" diff --name-only "$base"...HEAD 2>/dev/null \
    | sed -n 's#^packs/\([^/]*\)/.*#\1#p' | sort -u)
fi
if [ "${#ids[@]}" -eq 0 ]; then echo "No packs to smoke-test."; exit 0; fi
echo "Smoke-testing: ${ids[*]}"
echo

# Primary HTTP port for the probe: prefer a port named http/https/admin/web,
# else the first static port in the rendered jobspec.
primary_port() {
  local spec="$1"
  awk '
    /port[[:space:]]+"(http|https|admin|web|ui)"/ { grab=1 }
    grab && /static[[:space:]]*=/ { gsub(/[^0-9]/,"",$0); print; exit }
  ' "$spec"
}
first_port() {
  awk '/static[[:space:]]*=/ { gsub(/[^0-9]/,"",$0); if ($0!="") { print; exit } }' "$1"
}

for id in "${ids[@]}"; do
  case "$id" in _*) continue ;; esac
  if [ ! -d "$root/packs/$id" ]; then echo "• $id: no such pack dir, skipping"; continue; fi
  if [ -n "${SKIP[$id]:-}" ]; then echo "⊘ $id: skipped (${SKIP[$id]})"; record "$id" skipped "${SKIP[$id]}"; continue; fi

  echo "──────── $id ────────"
  if ! nomad-pack render "$root/packs/$id" >"$tmp/$id.raw" 2>"$tmp/$id.err"; then
    echo "✗ $id: render failed"; sed 's/^/    /' "$tmp/$id.err"; record "$id" failed "render failed"; fail=1; continue
  fi
  sed -n '/^job /,$p' "$tmp/$id.raw" >"$tmp/$id.nomad"
  job="$(awk -F'"' '/^job /{print $2; exit}' "$tmp/$id.nomad")"
  if [ -z "$job" ]; then echo "✗ $id: could not parse job name"; record "$id" failed "no job name"; fail=1; continue; fi

  # Ensure a clean slate, then run.
  nomad job stop -purge "$job" >/dev/null 2>&1 || true
  if ! nomad job run -detach "$tmp/$id.nomad" >"$tmp/$id.run" 2>&1; then
    echo "✗ $id: nomad job run rejected the job"; sed 's/^/    /' "$tmp/$id.run"; record "$id" failed "job rejected"; fail=1
    nomad job stop -purge "$job" >/dev/null 2>&1 || true; continue
  fi

  # Wait for a running allocation.
  ok=0; deadline=$(( $(date +%s) + BOOT_TIMEOUT ))
  while [ "$(date +%s)" -lt "$deadline" ]; do
    statuses="$(nomad job allocs -t '{{range .}}{{.ClientStatus}} {{end}}' "$job" 2>/dev/null)"
    case "$statuses" in
      *running*) ok=1; break ;;
      *failed*|*lost*) : ;;  # keep waiting; the scheduler may reschedule
    esac
    sleep 3
  done
  if [ "$ok" != 1 ]; then
    echo "✗ $id: allocation never reached running within ${BOOT_TIMEOUT}s"; record "$id" failed "never reached running"
    nomad job status "$job" 2>&1 | sed 's/^/    /' | head -30
    nomad job stop -purge "$job" >/dev/null 2>&1 || true; fail=1; continue
  fi

  # Must STAY running (not crash-loop) for the settle window.
  alloc="$(nomad job allocs -t '{{range .}}{{.ID}} {{end}}' "$job" 2>/dev/null | awk '{print $1}')"
  r0="$(nomad alloc status "$alloc" 2>/dev/null | awk -F= '/Restarts\/Interval/{gsub(/ /,"",$2);print $2}' | cut -d/ -f1)"
  sleep "$SETTLE_SECONDS"
  statuses="$(nomad job allocs -t '{{range .}}{{.ClientStatus}} {{end}}' "$job" 2>/dev/null)"
  r1="$(nomad alloc status "$alloc" 2>/dev/null | awk -F= '/Restarts\/Interval/{gsub(/ /,"",$2);print $2}' | cut -d/ -f1)"
  if [[ "$statuses" != *running* ]]; then
    echo "✗ $id: allocation did not stay running (status: $statuses)"; record "$id" failed "did not stay running"
    nomad alloc logs -stderr "$alloc" 2>/dev/null | tail -25 | sed 's/^/    /'
    nomad job stop -purge "$job" >/dev/null 2>&1 || true; fail=1; continue
  fi
  if [ -n "${r0:-}" ] && [ -n "${r1:-}" ] && [ "$r1" -gt "$r0" ] 2>/dev/null; then
    echo "✗ $id: container is crash-looping (restarts $r0 → $r1)"; record "$id" failed "crash-looping"
    nomad alloc logs -stderr "$alloc" 2>/dev/null | tail -25 | sed 's/^/    /'
    nomad job stop -purge "$job" >/dev/null 2>&1 || true; fail=1; continue
  fi

  # Best-effort HTTP probe (non-fatal): any response means it's listening.
  port="$(primary_port "$tmp/$id.nomad")"; [ -z "$port" ] && port="$(first_port "$tmp/$id.nomad")"
  probe="no http port found"
  if [ -n "$port" ]; then
    code="$(curl -s -o /dev/null -m 8 -w '%{http_code}' "http://127.0.0.1:$port/" 2>/dev/null)"
    if [ -n "$code" ] && [ "$code" != "000" ]; then probe="HTTP $code on :$port"; else
      # try https for TLS-only admin UIs
      code="$(curl -sk -o /dev/null -m 8 -w '%{http_code}' "https://127.0.0.1:$port/" 2>/dev/null)"
      [ -n "$code" ] && [ "$code" != "000" ] && probe="HTTPS $code on :$port" || probe="no HTTP response on :$port (running anyway)"
    fi
  fi
  echo "✓ $id: booted and held running ${SETTLE_SECONDS}s — $probe"; record "$id" pass "$probe"
  nomad job stop -purge "$job" >/dev/null 2>&1 || true
done

echo
if [ "$fail" = 0 ]; then echo "Smoke-test: all packs booted cleanly."; else echo "Smoke-test: some packs failed." >&2; fi
exit $fail
