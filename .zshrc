# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# echo "hello from zshrc"
# profiler
# export DISABLE_AUTO_UPDATE=true
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

#ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH=$HOME/.oh-my-zsh
plugins=(vi-mode autojump)
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# export SSH_KEY_PATH="~/.ssh/rsa_id"
# Auto add keys?
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# ssh-add -A

# use vim
set -o vi

# export my custom bind
export PATH=$PATH:$HOME/.local/bin

# export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go

# test 
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# pretty man
export MANPAGER='nvim +Man!'
export EDITOR=nvim

### git aliases
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
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset head~1'
alias orig="find . -name '*.orig' -delete"
alias removemerge='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
alias vim='/usr/bin/vim'
alias v='nvim'
alias vrc='nvim ~/.config/nvim/init.lua'
alias ll='ls -la'
alias b='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'
alias d='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git branch -D'
alias fzfkill='ps -ef | awk "{print \$2, \$8}" | fzf --height=40% --reverse --info=inline | awk "{print \$1}" | xargs kill -9'

# First source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Then configure FZF options
export FZF_COMPLETION_TRIGGER='~~'
export FZF_DEFAULT_OPTS="--height 40% --reverse"
export FZF_CTRL_R_OPTS="
  --no-info
  --preview 'echo {2..}' 
  --preview-window 'right:40%:hidden:wrap' 
  --bind 'ctrl-p:toggle-preview' 
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' 
  --color header:italic 
  --header 'Press CTRL-P to toggle preview, CTRL-Y to copy command' 
  --height 60%
"

# Ensure key bindings are set
bindkey '^R' fzf-history-widget

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

export BRAVE_API_KEY=$(pass show nico/brave)
