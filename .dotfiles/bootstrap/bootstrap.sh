#!/bin/bash
set -e
trap 'echo "ERROR: Bootstrap failed at line $LINENO"' ERR

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

case "$(uname -s)" in
Darwin)
  "$SCRIPT_DIR/bootstrap_darwin.sh"
  ;;
Linux)
  if command -v dnf >/dev/null 2>&1; then
    "$SCRIPT_DIR/bootstrap_fedora.sh"
  elif command -v pacman >/dev/null 2>&1; then
    "$SCRIPT_DIR/bootstrap_arch.sh"
  else
    echo "Unsupported Linux distribution"
    exit 1
  fi
  ;;
*)
  echo "Unsupported OS"
  exit 1
  ;;
esac

"$SCRIPT_DIR/bootstrap_common.sh"
