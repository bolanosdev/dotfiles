#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# install_software.sh — installs all tools. No user interaction
# required (no logins, no prompts). Safe to re-run any number
# of times: every step checks current state before acting.
# ============================================================

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/common.sh"

# ---- yay (AUR helper) ----
install_yay() {
  if command -v yay &>/dev/null; then
    log "yay already installed"
    return
  fi
  log "Installing yay"
  sudo pacman -S --needed --noconfirm git base-devel
  local tmpdir
  tmpdir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  (cd "$tmpdir/yay" && makepkg -si --noconfirm)
  rm -rf "$tmpdir"
}

install_pacman_pkgs() {
  log "Installing pacman packages: ${PACMAN_PKGS[*]}"
  # --needed makes this a no-op for anything already installed.
  sudo pacman -Syu --needed --noconfirm "${PACMAN_PKGS[@]}"
}

install_aur_pkgs() {
  log "Installing AUR packages: ${AUR_PKGS[*]}"
  yay -S --needed --noconfirm "${AUR_PKGS[@]}"
}

ensure_xattr_shim() {
  # Some Homebrew formulae (e.g. the go-task tap) call /usr/bin/xattr
  # directly, which only exists on macOS. Harmless no-op shim so those
  # formulae install cleanly on Linux too.
  if [[ -e /usr/bin/xattr ]]; then
    return
  fi
  log "Creating no-op /usr/bin/xattr shim (needed by some Homebrew formulae on Linux)"
  sudo tee /usr/bin/xattr >/dev/null <<'EOF'
#!/usr/bin/env bash
# no-op: macOS's xattr utility doesn't exist on Linux; some Homebrew
# formulae call it directly regardless. Safe to no-op here.
exit 0
EOF
  sudo chmod +x /usr/bin/xattr
}

install_brew() {
  if command -v brew &>/dev/null; then
    log "Homebrew already installed"
    return
  fi
  log "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew_shellenv
}

install_brew_pkgs() {
  brew_shellenv
  log "Installing Homebrew packages: ${BREW_PKGS[*]}"
  for pkg in "${BREW_PKGS[@]}"; do
    brew list --formula "$pkg" &>/dev/null || brew install "$pkg"
  done
}

install_bun() {
  if command -v bun &>/dev/null; then
    log "bun already installed"
    return
  fi
  log "Installing bun"
  curl -fsSL https://bun.sh/install | bash
}

install_fnm() {
  if command -v fnm &>/dev/null; then
    log "fnm already installed"
    return
  fi
  log "Installing fnm"
  curl -fsSL https://fnm.vercel.app/install | bash
}

# brew/bun/fnm's own installers write bash/zsh rc lines automatically, but
# none of them touch fish. This wires all three into fish so they're on
# PATH in new interactive sessions.
configure_fish_shell() {
  log "Wiring brew/bun/fnm into fish config"

  fish_config_add_block "bootstrap: homebrew" \
'if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
end'

  fish_config_add_block "bootstrap: bun" \
'set --export BUN_INSTALL "$HOME/.bun"
if test -d $BUN_INSTALL/bin
    set --export PATH $BUN_INSTALL/bin $PATH
end'

  fish_config_add_block "bootstrap: fnm" \
'if type -q fnm
    fnm env --use-on-cd | source
end'
}

install_hyprmod() {
  if command -v hyprmod &>/dev/null; then
    log "hyprmod already installed"
    return
  fi
  log "Installing hyprmod"
  curl -LsSf "$HYPRMOD_INSTALL_URL" | sh
}

install_claude_code() {
  if command -v claude &>/dev/null; then
    log "claude-code already installed"
    return
  fi
  log "Installing Claude Code"
  curl -fsSL https://claude.ai/install.sh | bash
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.config/fish/config.fish && source ~/.config/fish/config.fish
}

main() {
  install_yay
  install_pacman_pkgs
  install_aur_pkgs
  install_brew
  ensure_xattr_shim
  install_brew_pkgs
  install_bun
  install_fnm
  configure_fish_shell
  install_hyprmod
  install_claude_code

  log "install_software.sh done."
  echo "Still need your input on: cloudflare-cli, herdr (see notes in common.sh)."
}

main "$@"
echo
echo "Run 'exec fish' to reload your shell with the new PATH entries."
