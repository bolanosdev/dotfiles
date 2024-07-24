CF_PATH="~/cf-repos"
ZSC_PATH="~/.config/zsh"
NVC_PATH="~/.config/nvim"
ALA_PATH="~/.config/alacritty"

alias zu="source ~/.zshrc"
alias ala="cd ${ALA_PATH}"
alias nvc="cd ${NVC_PATH}"
alias zsc="cd ${ZSC_PATH}"
alias pr="cd ~/Projects/"
alias phx="cd ~/Projects/phoenix-ui"
alias phxw="cd ~/Projects/phoenix-ui-web"
alias bd="cd ~/Projects/bolanos-dev"
alias cf="cd ${CF_PATH}"
alias str="cd ${CF_PATH}/stratus/"
alias ts="cd ${CF_PATH}/tenant-service"
alias mcf="cd ${CF_PATH}/dashboard-apps"
alias cds="cd ${CF_PATH}/core-dev-stack"
alias cfw="cd ${CF_PATH}/cf-www"
alias cfs="cd ${CF_PATH}/cf-sql"

alias clean_vim="cd ~/.local/state/nvim/swap && rm *"
alias edit="nvim ."

alias gs="git status"

git.db() {
	git for-each-ref --format '%(refname:short)' refs/heads | grep -v "main" | xargs git branch -D
}

git.graph() {
  git log --oneline --graph --parents
}

git.log() {
  logCount="${1:=10}"
  git lg -$logCount | tail
}

git.cat() {
  git cat-file -p $1
}

disappointed() { echo -n " ಠ_ಠ " |tee /dev/tty| xclip -selection clipboard; }

flip() { echo -n "（╯°□°）╯ ┻━┻" |tee /dev/tty| xclip -selection clipboard; }

shrug() { echo -n "¯\_(ツ)_/¯" |tee /dev/tty| xclip -selection clipboard; }

matrix() { echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4;        letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}' }

