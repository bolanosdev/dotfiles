#!/usr/bin/env bash
# ============================================================
# common.sh — shared config + helpers.
# Sourced by the other scripts; not meant to be run directly.
# Every function anywhere in this suite must be safe to re-run:
# check current state first, only act if something is missing.
# ============================================================

log()  { echo -e "\n\033[1;32m==>\033[0m $1"; }
warn() { echo -e "\n\033[1;33m[!]\033[0m $1"; }

# ---- Package lists (edit these) ----
PACMAN_PKGS=(
  docker
  docker-compose
  go
  rust
  neovim
  fzf
  ffmpeg
  zig
  dotnet-sdk
  github-cli   # provides `gh`, used to upload your SSH key to GitHub
  glab
  lazygit
)

AUR_PKGS=(
  ghostty
  terraform-bin
  doctl-bin
  1password
  1password-cli
  kubectl
  k9s
  kubie
  minikube
)

BREW_PKGS=(
  gnupg
  dopplerhq/cli/doppler
  go-task/tap/go-task
)

# Things below still need a review pass with you:
#   - cloudflare-cli -> could mean `cloudflared` (tunnel daemon, in AUR) or `wrangler`
#                       (Workers CLI, installed via bun/npm). Not added — which one?
#   - herdr        -> not a package I recognize either (Laravel Herd? a typo for something
#                     else?). Not added — tell me what this is.

HYPRMOD_INSTALL_URL="https://raw.githubusercontent.com/BlueManCZ/hyprmod/main/install.sh"

# ---- Folders ----
DIRS=(
  "$HOME/Pictures/Wallpapers"
  "$HOME/Projects"
)

# ---- Dotfiles / dev env ----
DOTFILES_REPO="https://github.com/bolanosdev/dotfiles.git"
DOTFILES_DIR="$HOME/Projects/dotfiles"

# ---- git / ssh identity ----
GIT_NAME="Carlos Bolanos"
GIT_EMAIL="mail@bolanos.dev"
SSH_KEY="$HOME/.ssh/id_rsa"

# ---- Homebrew (Linuxbrew) shell env, needed by any script calling brew ----
brew_shellenv() {
  if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

# ---- fish shell config, so brew/fnm/bun are on PATH in interactive sessions ----
FISH_CONFIG="$HOME/.config/fish/config.fish"

# Appends a marked block to config.fish if a block with that marker isn't
# already present. Safe to call repeatedly — each marker is only ever added once.
fish_config_add_block() {
  local marker="$1"
  local block="$2"

  mkdir -p "$(dirname "$FISH_CONFIG")"
  touch "$FISH_CONFIG"

  if grep -qF "# $marker" "$FISH_CONFIG"; then
    return
  fi
  log "Adding '$marker' block to $FISH_CONFIG"
  {
    echo ""
    echo "# $marker"
    echo "$block"
  } >> "$FISH_CONFIG"
}
