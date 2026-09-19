#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# dev_env_changes.sh — dev environment config: clone dotfiles,
# symlink nvim config. Safe to re-run any number of times.
# ============================================================

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/common.sh"

clone_dotfiles() {
  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    log "dotfiles repo already cloned at $DOTFILES_DIR — pulling latest"
    git -C "$DOTFILES_DIR" pull --ff-only
  else
    log "Cloning dotfiles into $DOTFILES_DIR"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi
}

link_nvim_config() {
  local src="$SCRIPT_DIR/nvim"
  local dest="$HOME/.config/nvim"

  if [[ ! -d "$src" ]]; then
    warn "No nvim folder found in dotfiles repo ($src) — skipping nvim config symlink"
    return
  fi

  if [[ -L "$dest" ]]; then
    if [[ "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
      log "$dest already symlinked to $src"
      return
    fi
    warn "Removing existing symlink at $dest"
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    local backup
    backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
    warn "Backing up existing $dest to $backup"
    mv "$dest" "$backup"
  fi

  mkdir -p "$HOME/.config"
  log "Symlinking $dest -> $src"
  ln -s "$src" "$dest"
}

main() {
  clone_dotfiles
  link_nvim_config

  log "dev_env_changes.sh done."
}

main "$@"
