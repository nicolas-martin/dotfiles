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

export SSH_KEY_PATH="~/.ssh/rsa_id"
# Auto add keys?
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# ssh-add -A

# use vim
set -o vi

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
alias gwip='git add -a; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset head~1'
alias orig="find . -name '*.orig' -delete"
alias removemerge='git branch --merged | grep -v "\*" | grep -v master | grep -v dev | xargs -n 1 git branch -d'
alias vim='/usr/bin/vim'
alias v='nvim'
alias vrc='nvim ~/.config/nvim/init.lua'
alias ll='ls -la'
alias ghc='/usr/local/bin/gh'
alias b='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'
alias d='git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git branch -D'
alias killwf='f(){yes | ./bin/rewarder workflow terminate $(pbpaste) ""};f'
alias killall="cadence --domain coinbase workflow list --op --pjson | jq -r '.[].execution.workflowId' | grep -v hearbeat | xargs -n 1 cadence --domain coinbase workflow term --workflow_id"
alias cssh='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

## export NVM_DIR="$HOME/.nvm"
## [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
## [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export FZF_CTRL_R_OPTS='--preview-window=up:10:wrap --preview="echo {}" --height 100%'
export FZF_CTRL_R_OPTS="--height 50% --preview 'echo {2..} | bat --color=always -pl sh' --preview-window 'wrap,down,5'"


#source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
