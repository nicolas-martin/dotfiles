# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  vi-mode
  # ssh-agent
)

source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
ssh-add -A

# One history per window?
unsetopt inc_append_history
unsetopt share_history

# use vim
set -o vi
export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOBIN

# ruby
eval "$(rbenv init -)"

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

alias k='kubectl'
alias vim='nvim'
alias v='nvim'
alias vrc='nvim ~/.config/nvim/init.vim'
alias gh='cd ~/go/src/github.com/punchh/'
alias ll='ls -la'

if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nmartin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nmartin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nmartin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nmartin/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
