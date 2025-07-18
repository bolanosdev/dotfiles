set -gx NVM_DIR $HOME/.nvm
set -gx PATH $PATH ~/go/bin #dlv
set -x FISH_DIR ~/.config/fish

source $FISH_DIR/env.fish
source $FISH_DIR/alias.fish
source $FISH_DIR/functions.fish
source $FISH_DIR/nvm.fish


if status is-interactive
    atuin init fish | source
end


# Added by Windsurf
# fish_add_path /Users/cbolanos/.codeium/windsurf/bin
