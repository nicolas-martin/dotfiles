# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/nma/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  git
  # ssh-agent
)

source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
ssh-add -A

# use vim
set -o vi
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOBIN
alias st='git status '
alias ga='git add '
alias br='git branch '
alias ci='git commit '
alias dt='git difftool'
alias co='git checkout '
alias last='git last'
alias pu='git push '
alias last='git log -1'

alias re='git fetch origin master;git rebase origin/master'
alias g='git '
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'
alias orig="find . -name '*.orig' -delete"
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias removemerge='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
alias mkcd='_(){ mkdir $1; cd $1; }; _'
alias k='kubectl'
alias vim='nvim'
alias v='nvim'

if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

