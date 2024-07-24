export ZSH="$HOME/.oh-my-zsh"
export PATH="/Users/cbolanos/Library/Application Support/fnm:$PATH"
export NPM_TOKEN=$(/opt/homebrew/bin/cloudflared access login https://registry.cloudflare-ui.com | grep ey)

ZSH_THEME="robbyrussell"
plugins=(git direnv z)

source $ZSH/oh-my-zsh.sh
eval "$(direnv hook zsh)"
export VAULT_ADDR=https://vault.cfdata.org:8200
export VAULT_CACERT=cfks.crt

. /opt/homebrew/etc/profile.d/z.sh
