echo "hello from zshrc"

export ZSH="/Users/nma/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
ZSH_THEME="robbyrussell"
plugins=(vi-mode autojump kubectl)

source $ZSH/oh-my-zsh.sh
export SSH_KEY_PATH="~/.ssh/rsa_id"
# Auto add keys?
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

#CB
export GO111MODULE=on # can be skipped if project files are located outside of your GOPATH already.
export GOPROXY=https://gomodules.cbhq.net/
export GONOSUMDB=github.cbhq.net  


# ssh-add -A

# use vim
set -o vi

# export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go

# test 
# export GOROOT=/usr/local/opt/go@1.20/libexec
# export PATH="/usr/local/opt/go@1.20/bin:$PATH"
# export GOROOT=/usr/local/opt/go@1.19/libexec
# export PATH="/usr/local/opt/go@1.19/bin:$PATH"
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
alias vim='/usr/bin/vim'
alias v='nvim'
alias vrc='nvim ~/.config/nvim/init.lua'
alias ll='ls -la'
alias ghc='/usr/local/bin/gh'
alias b='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'
alias d='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git branch -D'

alias cssh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# Get autocompelte with catalina
autoload -U compinit && compinit

#ruby
export GEM_HOME="$HOME/.gem"
eval "$(rbenv init - zsh)"
export PATH="$GEM_HOME/bin:$PATH"
# export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
# export LDFLAGS="-L/Users/nma/.rbenv/versions/2.6.9/lib"
# export CPPFLAGS="-I/Users/nma/.rbenv/versions/2.6.9/include"
# export PKG_CONFIG_PATH="/Users/nma/.rbenv/versions/2.6.9/lib/pkgconfig"


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
alias killwf='f(){yes | ./bin/rewarder workflow terminate $(pbpaste) ""};f'
alias killall="cadence --domain coinbase workflow list --op --pjson | jq -r '.[].execution.workflowId' | grep -v hearbeat | xargs -n 1 cadence --domain coinbase workflow term --workflow_id"


# export RUBY_CFLAGS="-Wno-error=implicit-function-declaration -DUSE_FFI_CLOSURE_ALLOC"
#eval "$($(go env GOPATH)/bin/assume-role -init)"

# export PRIME_API_GATEWAY_PATH="/Users/nma/dev/prime-api-gateway"
# export MONOREPO_PATH="/Users/nma/dev/repo"
# source $MONOREPO_PATH/scripts/rc/rc.sh

export PATH="/usr/local/sbin:$PATH"


# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
