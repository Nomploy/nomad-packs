#!/usr/bin/env bash
# Renders every pack with nomad-pack and validates the rendered job with nomad.
# Requires `nomad-pack` in PATH. If `nomad` is present and an agent is reachable
# (NOMAD_ADDR), each job is also run through `nomad job validate`.
# Usage: scripts/validate-packs.sh
set -uo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp -d)"
fail=0

if ! command -v nomad-pack >/dev/null 2>&1; then
  echo "nomad-pack not found in PATH" >&2
  exit 2
fi
have_nomad=0
command -v nomad >/dev/null 2>&1 && have_nomad=1

for dir in "$root"/packs/*/; do
  id="$(basename "$dir")"
  case "$id" in _*) continue ;; esac

  if ! nomad-pack render "$dir" >"$tmp/$id.raw" 2>"$tmp/$id.err"; then
    echo "✗ $id: render failed"
    sed 's/^/    /' "$tmp/$id.err"
    fail=1
    continue
  fi

  # Extract the job HCL from the render output.
  sed -n '/^job /,$p' "$tmp/$id.raw" >"$tmp/$id.nomad"

  if [ "$have_nomad" = 1 ]; then
    if nomad job validate "$tmp/$id.nomad" >/dev/null 2>"$tmp/$id.verr"; then
      echo "✓ $id"
    else
      echo "✗ $id: nomad job validate failed"
      sed 's/^/    /' "$tmp/$id.verr"
      fail=1
    fi
  else
    echo "✓ $id (rendered ok; nomad not found — skipped validate)"
  fi
done

echo
if [ "$fail" = 0 ]; then
  echo "All packs rendered/validated cleanly."
else
  echo "Some packs failed." >&2
fi
exit $fail
