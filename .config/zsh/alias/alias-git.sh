alias gs="git status"

git.db() {
  git for-each-ref --format '%(refname:short)' refs/heads | grep -v "main" | xargs git branch -D
}

git.graph() {
  git log --oneline --graph --parents
}

git.branch() {
  git branch | awk -F ' +' '! /\(no branch\)/ {print $2}'
}

git.log() {
  logCount="${1:=10}"
  git lg -$logCount | cat
}

git.cat() {
  git cat-file -p $1
}
