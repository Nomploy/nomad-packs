#!/bin/sh
# Nomploy Nomad Packs — one-liner installer.
#
#   # just add the registry:
#   curl -fsSL https://packs.nomploy.com/install.sh | sh
#
#   # add the registry and run one or more packs:
#   curl -fsSL https://packs.nomploy.com/install.sh | sh -s -- grafana loki
#
# It only ever adds a nomad-pack registry and runs the packs you name — nothing else.
# Read it first if you like; it is short on purpose.
set -eu

REGISTRY_NAME="nomploy"
REGISTRY_URL="https://github.com/Nomploy/nomad-packs"

say() { printf '\033[36m==>\033[0m %s\n' "$1"; }
err() { printf '\033[31merror:\033[0m %s\n' "$1" >&2; }

if ! command -v nomad-pack >/dev/null 2>&1; then
  err "nomad-pack not found on PATH."
  echo "  Install it: https://developer.hashicorp.com/nomad/tools/nomad-pack" >&2
  exit 1
fi

# Add the registry (idempotent: refresh if it already exists).
if nomad-pack registry list 2>/dev/null | grep -q "$REGISTRY_NAME"; then
  say "Registry '$REGISTRY_NAME' already added — refreshing."
  nomad-pack registry add "$REGISTRY_NAME" "$REGISTRY_URL" >/dev/null 2>&1 || true
else
  say "Adding registry '$REGISTRY_NAME' ($REGISTRY_URL)"
  nomad-pack registry add "$REGISTRY_NAME" "$REGISTRY_URL"
fi

if [ "$#" -eq 0 ]; then
  say "Done. Browse packs at https://packs.nomploy.com and run one with:"
  echo "  nomad-pack run <pack> --registry $REGISTRY_NAME"
  exit 0
fi

for pack in "$@"; do
  say "Running pack '$pack'"
  nomad-pack run "$pack" --registry "$REGISTRY_NAME"
done

say "All done. Check status with: nomad job status"
