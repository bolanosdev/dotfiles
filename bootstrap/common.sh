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
  ant
  docker
  docker-compose
  go
  rust
  neovim
  fzf
  ffmpeg
  zig
  zip
  dotnet-sdk
  github-cli   # provides `gh`, used to upload your SSH key to GitHub
  glab
  lazygit
  weechat
  steam            # multilib repo
  faugus-launcher  # cachyos repo — Windows games via UMU-Launcher
  lutris           # Windows game launchers (e.g. WoW Ascension) via Wine
  wine             # multilib repo
  winetricks
  obs-studio       # extra repo
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
  zennotes-bin
)

BREW_PKGS=(
  gnupg
  dopplerhq/cli/doppler
  go-task/tap/go-task
)

# Packages previously installed that are no longer wanted. Not touched by
# install_software.sh — removed by uninstall_software.sh instead.
REMOVE_PKGS=(
  todoist-appimage   # replaced by zennotes-bin; SUPER+R now launches zennotes
)

# Things below still need a review pass with you:
#   - cloudflare-cli -> could mean `cloudflared` (tunnel daemon, in AUR) or `wrangler`
#                       (Workers CLI, installed via bun/npm). Not added — which one?

HYPRMOD_INSTALL_URL="https://raw.githubusercontent.com/BlueManCZ/hyprmod/main/install.sh"
HERDR_INSTALL_URL="https://herdr.dev/install.sh"

# ---- Folders ----
# Note: ~/Pictures/Wallpapers is not created here — it's symlinked to
# bootstrap/Wallpapers by dev_env_changes.sh instead.
DIRS=(
  "$HOME/Projects"
)

# ---- Dotfiles / dev env ----
DOTFILES_REPO="https://gitlab.com/bolanosdev/dotfiles.git"
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
