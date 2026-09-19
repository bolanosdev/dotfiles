#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# run_all.sh — runs everything in order. Each script is also
# runnable on its own (e.g. `./dev_env_changes.sh` after you've
# tweaked your dotfiles repo). Every step across all three
# scripts is safe to re-run any number of times.
# ============================================================

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

"$SCRIPT_DIR/install_software.sh"
"$SCRIPT_DIR/os_changes.sh"
"$SCRIPT_DIR/dev_env_changes.sh"

echo -e "\nAll done."
