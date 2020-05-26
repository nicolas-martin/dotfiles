# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  vi-mode
  # ssh-agent
)

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
# Auto add keys?
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# ssh-add -A

# use vim
set -o vi
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOBIN

# git aliases
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

alias wd='cd $GOPATH/src/github.com/nicolas-martin'

alias k='kubectl'
alias vim='/usr/bin/vim'
alias v='nvim'
alias vrc='nvim ~/.config/nvim/init.vim'
alias ll='ls -la'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
