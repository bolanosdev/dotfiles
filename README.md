# Post-format bootstrap

Scripts to rebuild your CachyOS/Arch + Hyprland toolchain from a fresh install.
Everything is idempotent — safe to re-run any of these any number of times.

## Quickstart

1. **Run `install_software.sh`**
   Installs everything: pacman/AUR packages, Homebrew + its formulas, bun,
   fnm, hyprmod, Claude Code, and wires brew/bun/fnm into your fish config.
   No interaction required.

   ```
   ./install_software.sh
   exec fish   # reload your shell to pick up the new PATH entries
   ```

2. **Run `os_changes.sh`**
   Creates `~/Pictures/Wallpapers` and `~/Projects`, sets your global git
   identity, generates `~/.ssh/id_rsa` if it doesn't exist, installs the
   fish aliases in `fish/`, uploads the SSH key to GitHub/GitLab, and sets
   up the docker group + service.

   GitHub/GitLab auth uses `gh auth login --web` / `glab auth login --web`
   — each opens a browser the first time it's needed, then reuses the
   stored credentials on later runs.

3. **Run `dev_env_changes.sh`**
   Clones your dotfiles repo into `~/Projects/dotfiles` and symlinks
   `~/.config/nvim` to `bootstrap/nvim/`.

Or just run `./run_all.sh` to do all three in order.

## Layout

| File | Purpose |
|---|---|
| `common.sh` | Shared package lists, paths, and helper functions. Sourced by the others. |
| `install_software.sh` | All package/tool installs. No prompts. |
| `os_changes.sh` | Folders, git identity, SSH key, fish aliases, docker group/service. |
| `dev_env_changes.sh` | Dotfiles clone + nvim symlink. |
| `fish/` | `gh-auth-test.fish`, `glab-auth-test.fish` — copied into `~/.config/fish/functions/` by `os_changes.sh`. Optional manual aliases for piping a token from 1Password into `gh`/`glab`, if you set that up later; not used by the scripts themselves. |
| `nvim/` | Your nvim config — symlinked to `~/.config/nvim` by `dev_env_changes.sh`. |
| `run_all.sh` | Runs the three main scripts in order. |

## Still open

- **cloudflare-cli** — `cloudflared` (tunnel daemon) or `wrangler` (Workers
  CLI)? Not added to any package list yet.
- **herdr** — not a recognized package name. Not added yet.
