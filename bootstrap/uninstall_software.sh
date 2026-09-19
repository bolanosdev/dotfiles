#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# uninstall_software.sh — removes packages listed in REMOVE_PKGS
# (common.sh) that used to be installed but aren't wanted anymore.
# Does not touch anything in PACMAN_PKGS/AUR_PKGS/BREW_PKGS — this
# is a deliberate removal list, not the inverse of install_software.sh.
# Safe to re-run any number of times: skips anything not installed.
# ============================================================

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/common.sh"

remove_pkgs() {
  local to_remove=()
  for pkg in "${REMOVE_PKGS[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
      to_remove+=("$pkg")
    else
      log "$pkg not installed — skipping"
    fi
  done

  if [[ ${#to_remove[@]} -eq 0 ]]; then
    log "Nothing to remove"
    return
  fi

  log "Removing packages: ${to_remove[*]}"
  sudo pacman -Rns --noconfirm "${to_remove[@]}"
}

main() {
  remove_pkgs

  log "uninstall_software.sh done."
}

main "$@"
