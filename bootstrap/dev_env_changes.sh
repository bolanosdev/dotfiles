#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# dev_env_changes.sh — dev environment config: clone dotfiles,
# symlink nvim/hypr config. Safe to re-run any number of times.
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

link_config() {
  local name="$1"
  local src="$2"
  local dest="$3"

  if [[ ! -e "$src" ]]; then
    warn "No $name path found in dotfiles repo ($src) — skipping $name config symlink"
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

  mkdir -p "$(dirname "$dest")"
  log "Symlinking $dest -> $src"
  ln -s "$src" "$dest"
}

main() {
  clone_dotfiles
  link_config "nvim" "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
  # ~/.config/hypr is caelestia's own managed clone — never touch it directly.
  # Overrides go through its two sanctioned override files instead.
  link_config "hypr-vars" "$SCRIPT_DIR/hypr/hypr-vars.lua" "$HOME/.config/caelestia/hypr-vars.lua"
  link_config "hypr cli.json" "$SCRIPT_DIR/hypr/cli.json" "$HOME/.config/caelestia/cli.json"
  link_config "wallpapers" "$SCRIPT_DIR/wallpapers" "$HOME/Pictures/Wallpapers"

  log "dev_env_changes.sh done."
}

main "$@"
