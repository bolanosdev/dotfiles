
ZSH_CONFIG_PATH=~/.config/zsh

source $ZSH_CONFIG_PATH/powerlevel10k.sh
source $ZSH_CONFIG_PATH/bun.sh
source $ZSH_CONFIG_PATH/alias.sh
source $ZSH_CONFIG_PATH/oh-my-zsh.sh
source $ZSH_CONFIG_PATH/brew.sh
source $ZSH_CONFIG_PATH/go.sh

  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
