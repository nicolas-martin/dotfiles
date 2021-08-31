echo "hello from zshrc"

export ZSH="/Users/nmartin/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(vi-mode autojump)

source $ZSH/oh-my-zsh.sh
export SSH_KEY_PATH="~/.ssh/rsa_id"
# Auto add keys?
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# ssh-add -A

# use vim
set -o vi
# export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go
# GOROOT changes on linux
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
# replace make with gmake
export PATH=$PATH:'/usr/local/opt/make/libexec/gnubin'

# pretty man
export MANPAGER='nvim +Man!'
export EDITOR=nvim

# git aliases
alias st='git status '
alias ga='git add '
alias br='git branch '
alias ci='git commit '
alias dt='git difftool'
alias co='git checkout '
alias pu='git push '
alias last='git log -1'
alias re='git fetch origin master;git rebase origin/master'
alias g='git '
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias orig="find . -name '*.orig' -delete"
alias removemerge='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
alias gh='cd $GOPATH/src/github.com/nicolas-martin/'
alias k='kubectl'
alias vim='/usr/bin/vim'
alias v='nvim'
alias vrc='nvim ~/.config/nvim/init.lua'
alias ll='ls -la'
alias ghc='/usr/local/bin/gh'
alias b='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'

alias cssh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias poetry=~/.poetry/bin/poetry

# Get autocompelte with catalina
autoload -U compinit && compinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

