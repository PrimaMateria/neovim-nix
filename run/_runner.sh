# Sourced by per-flavor scripts. Expects $FLAVOR to be set before sourcing.
# Usage: source "$(dirname "$0")/_runner.sh" "$@"

FLAKE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTANCE_ID=$$
SESSION_FILE="/tmp/nvim-session-${FLAVOR}-${INSTANCE_ID}.vim"
REBUILD_FLAG="/tmp/nvim-rebuild-${FLAVOR}-${INSTANCE_ID}"
NVIM="$FLAKE_DIR/result-${FLAVOR}/bin/nvim-${FLAVOR}"

rm -f "$REBUILD_FLAG"

if [[ ! -x "$NVIM" ]]; then
  echo "→ No build found for nvim-${FLAVOR}, building..."
  nix build "$FLAKE_DIR#neovim.${FLAVOR}" --out-link "$FLAKE_DIR/result-${FLAVOR}"
fi

while true; do
  if [[ -f "$SESSION_FILE" ]]; then
    NVIM_INSTANCE_ID="$INSTANCE_ID" NVIM_FLAVOR="$FLAVOR" "$NVIM" -S "$SESSION_FILE" "$@"
  else
    NVIM_INSTANCE_ID="$INSTANCE_ID" NVIM_FLAVOR="$FLAVOR" "$NVIM" "$@"
  fi

  if [[ -f "$REBUILD_FLAG" ]]; then
    rm -f "$REBUILD_FLAG"
    echo "→ Rebuilding nvim-${FLAVOR}..."
    nix build "$FLAKE_DIR#neovim.${FLAVOR}" --out-link "$FLAKE_DIR/result-${FLAVOR}"
    echo "→ Done. Restarting..."
  else
    rm -f "$SESSION_FILE"
    break
  fi
done
