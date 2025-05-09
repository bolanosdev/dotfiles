nvim_clean() {
  cd ~/.local/share/nvim/
  rm -rf *

  cd ~/local/state/nvim/
  rm -rf *

  cd ~/.cache/nvim/
  rm -rf *
}

alias op="nvim ."
alias db="nvim -c 'DBUI'"

