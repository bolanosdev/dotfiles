#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# os_changes.sh — system/account-level setup: folders, git
# identity, SSH key + upload, docker group/service.
# Safe to re-run any number of times.
# Note: GitHub/GitLab key upload opens an interactive browser login
# the first time it's needed (gh/glab have no way around that).
# ============================================================

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/common.sh"

make_dirs() {
  log "Ensuring folders exist: ${DIRS[*]}"
  mkdir -p "${DIRS[@]}"
}

setup_git_identity() {
  log "Setting git global user.name/user.email"
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
}

set_default_editor() {
  log "Setting nvim as the default editor (git core.editor, \$EDITOR/\$VISUAL)"
  git config --global core.editor "nvim"

  fish_config_add_block "bootstrap: default editor" \
'set --export EDITOR nvim
set --export VISUAL nvim'
}

generate_ssh_key() {
  if [[ -f "$SSH_KEY" ]]; then
    log "SSH key already exists at $SSH_KEY"
    return
  fi
  log "Generating SSH key at $SSH_KEY"
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  # RSA 4096 as requested. ed25519 is the current recommendation if you
  # ever want to switch (`ssh-keygen -t ed25519`), but this matches what
  # you asked for.
  ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -f "$SSH_KEY" -N ""
}

install_fish_aliases() {
  local src_dir="$SCRIPT_DIR/fish"
  local dest_dir="$HOME/.config/fish/functions"

  if [[ ! -d "$src_dir" ]]; then
    warn "No fish folder found at $src_dir — skipping"
    return
  fi

  mkdir -p "$dest_dir"
  log "Copying fish functions into $dest_dir"
  cp -f "$src_dir"/*.fish "$dest_dir"/
}

upload_ssh_key_github() {
  if ! command -v gh &>/dev/null; then
    warn "gh (GitHub CLI) not installed — skipping GitHub key upload"
    return
  fi

  if ! gh auth status &>/dev/null; then
    log "Logging into GitHub (gh will open a browser / give you a device code)"
    gh auth login --hostname github.com --git-protocol ssh --web
  fi

  local local_key
  local_key=$(awk '{print $2}' "${SSH_KEY}.pub")

  log "Comparing local SSH key against keys already on GitHub"
  if gh ssh-key list 2>/dev/null | grep -qF "$local_key"; then
    log "SSH key already registered on GitHub — skipping upload"
  else
    log "No match found — uploading SSH key to GitHub"
    gh ssh-key add "${SSH_KEY}.pub" --title "$(hostname)-$(date +%Y%m%d)"
  fi
}

upload_ssh_key_gitlab() {
  if ! command -v glab &>/dev/null; then
    warn "glab (GitLab CLI) not installed — skipping GitLab key upload"
    return
  fi

  if ! glab auth status &>/dev/null; then
    log "Logging into GitLab (glab will open a browser)"
    glab auth login --hostname gitlab.com --git-protocol ssh --web
  fi

  local local_key
  local_key=$(awk '{print $2}' "${SSH_KEY}.pub")

  log "Comparing local SSH key against keys already on GitLab"
  if glab ssh-key list 2>/dev/null | grep -qF "$local_key"; then
    log "SSH key already registered on GitLab — skipping upload"
  else
    log "No match found — uploading SSH key to GitLab"
    glab ssh-key add "${SSH_KEY}.pub" --title "$(hostname)-$(date +%Y%m%d)"
  fi
}

enable_docker() {
  log "Configuring Docker group/service"

  if ! getent group docker &>/dev/null; then
    log "Creating docker group"
    sudo groupadd docker
  fi

  if ! groups "$USER" | grep -q '\bdocker\b'; then
    sudo usermod -aG docker "$USER"
    warn "Added $USER to docker group — log out/in for it to take effect"
  fi

  sudo systemctl enable --now docker
}

main() {
  make_dirs
  setup_git_identity
  set_default_editor
  generate_ssh_key
  install_fish_aliases
  upload_ssh_key_github
  upload_ssh_key_gitlab
  enable_docker

  log "os_changes.sh done."
}

main "$@"
