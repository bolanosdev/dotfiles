# Post-format bootstrap

Scripts to rebuild your CachyOS/Arch + Hyprland toolchain from a fresh install.
Everything is idempotent — safe to re-run any of these any number of times.

## Quickstart

1. **Run `install_software.sh`**
   Installs everything: pacman/AUR packages, Homebrew + its formulas, bun,
   fnm, sdkman + Java 25, hyprmod, herdr, Claude Code, and wires
   brew/bun/fnm/java into your fish config.
   No interaction required.

   ```
   ./install_software.sh
   exec fish   # reload your shell to pick up the new PATH entries
   ```

2. **Run `os_changes.sh`**
   Creates `~/Projects`, sets your global git identity, sets `nvim` as the
   default editor (`git core.editor`, `$EDITOR`/`$VISUAL`), generates
   `~/.ssh/id_rsa` if it doesn't exist, installs the fish aliases in
   `fish/`, uploads the SSH key to GitHub/GitLab, and sets up the docker
   group + service.

   GitHub/GitLab auth uses `gh auth login --web` / `glab auth login --web`
   — each opens a browser the first time it's needed, then reuses the
   stored credentials on later runs.

3. **Run `dev_env_changes.sh`**
   Clones your dotfiles repo into `~/Projects/dotfiles`, and symlinks:
   `~/.config/nvim` to `bootstrap/nvim/`; the two caelestia override files
   (`~/.config/caelestia/hypr-vars.lua` and `cli.json`) to `bootstrap/hypr/`
   (`~/.config/hypr` itself is caelestia's own managed clone and is never
   touched directly); and `~/Pictures/Wallpapers` to `bootstrap/wallpapers/`.

Or just run `./run_all.sh` to do all three in order.

Separately, **`uninstall_software.sh`** removes packages listed in
`REMOVE_PKGS` (common.sh) that used to be installed but aren't wanted
anymore — currently just `todoist-appimage`, replaced by `zennotes-bin`.
It's not part of `run_all.sh`; run it manually when you want to prune
something.

## Layout

| File | Purpose |
|---|---|
| `common.sh` | Shared package lists, paths, and helper functions. Sourced by the others. |
| `install_software.sh` | All package/tool installs. No prompts. |
| `uninstall_software.sh` | Removes packages listed in `REMOVE_PKGS`. Run manually, not part of `run_all.sh`. |
| `os_changes.sh` | Folders, git identity, SSH key, fish aliases, docker group/service. |
| `dev_env_changes.sh` | Dotfiles clone + nvim/wallpapers symlinks + caelestia override symlinks. |
| `fish/` | `gh-auth-test.fish`, `glab-auth-test.fish` — copied into `~/.config/fish/functions/` by `os_changes.sh`. Optional manual aliases for piping a token from 1Password into `gh`/`glab`, if you set that up later; not used by the scripts themselves. |
| `nvim/` | Your nvim config — symlinked to `~/.config/nvim` by `dev_env_changes.sh`. |
| `hypr/` | [caelestia](https://github.com/caelestia-dots/caelestia) override files — never touch `~/.config/hypr` itself. `hypr-vars.lua` overrides simple keybind/variable values; `cli.json`'s `toggles.<workspace>` key overrides the app(s) each special workspace spawns. `SUPER + R` toggles the `todo` workspace; `cli.json` disables the default `todoist` toggle and enables `zennotes` instead. Both symlinked to `~/.config/caelestia/` by `dev_env_changes.sh`. |
| `wallpapers/` | Wallpaper images, pulled from [mohammedmehdio/Wallpaper-Collection](https://github.com/mohammedmehdio/Wallpaper-Collection) and [laustoic/laustoic-wallpaper-repo](https://github.com/laustoic/laustoic-wallpaper-repo) (each subfolder keeps that repo's LICENSE). Symlinked to `~/Pictures/Wallpapers` by `dev_env_changes.sh`. |
| `run_all.sh` | Runs the three main scripts in order. |

## Still open

- **cloudflare-cli** — `cloudflared` (tunnel daemon) or `wrangler` (Workers
  CLI)? Not added to any package list yet.
