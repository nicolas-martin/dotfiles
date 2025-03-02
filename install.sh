#!/bin/bash

info() {
  echo "$@"
}

warn() {
  echo "$(tput setaf 1)$@$(tput sgr0)"
}

install() {
  local src="$(pwd)/$1"
  local dst=${2:-"$HOME/$1"}
  
  if [ ! -e "$src" ]; then
    warn "Source file $src does not exist. Skipping."
    return
  fi

  info "Linking $src to $dst"
  mkdir -p "$(dirname "$dst")" # Ensure the directory exists
  if ln -sf "$src" "$dst"; then
    info "Successfully linked $src to $dst"
  else
    warn "Failed to link $src to $dst"
  fi
}

gitstall() {
  if [ -d "$2" ]; then
    rm -rf "$2"
  fi
  git clone "$1" "$2"
  info "Cloning $1 to $2"
}

warn "Symlinking files"

# General dotfiles
install .gitconfig
install .zshrc
install .tmux.conf
install alacritty.toml "$HOME/.config/alacritty/alacritty.toml"

# Neovim configuration
install init.lua "$HOME/.config/nvim/init.lua"
install lua/plugins.lua "$HOME/.config/nvim/lua/plugins.lua"
install lua/settings.lua "$HOME/.config/nvim/lua/settings.lua"
install lua/keymaps.lua "$HOME/.config/nvim/lua/keymaps.lua"
install lua/lsp.lua "$HOME/.config/nvim/lua/lsp.lua"
install lua/autocmds.lua "$HOME/.config/nvim/lua/autocmds.lua"
install lua/telescope_config.lua "$HOME/.config/nvim/lua/telescope_config.lua"
install lua/cmp_config.lua "$HOME/.config/nvim/lua/cmp_config.lua"
install lua/treesitter.lua "$HOME/.config/nvim/lua/treesitter.lua"

# Uncomment these if you want to use them
# install base.vim "$HOME/base.vim"
# install .gitattributes

warn "Installation complete!"
