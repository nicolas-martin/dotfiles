# echo "hello from zshrc"
# profiler
# export DISABLE_AUTO_UPDATE=true
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

export ZSH=$HOME/.oh-my-zsh
plugins=(vi-mode autojump)
source $ZSH/oh-my-zsh.sh

# export SSH_KEY_PATH="~/.ssh/rsa_id"
# Auto add keys?
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# ssh-add -A

# use vim
set -o vi

# export my custom bind
export PATH=$PATH:$HOME/.local/bin

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

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
alias orig='git ls-files --others --exclude-standard | grep "\.orig$" | xargs -r rm'
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

export GEMINI_API_KEY=$(pass show nico/gemini)
export BRAVE_API_KEY=$(pass show nico/brave)
eval "$(starship init zsh)"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export PATH="/Users/nma/.yarn/bin:$PATH"

export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

alias claude="/Users/nma/.claude/local/claude"
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.4.1
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# bun completions
[ -s "/Users/nma/.oh-my-zsh/completions/_bun" ] && source "/Users/nma/.oh-my-zsh/completions/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
