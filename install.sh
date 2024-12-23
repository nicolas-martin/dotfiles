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
  info "linking $src to $dst"
  ln -sf $src $dst
  # cp $src $dst
}

gitstall() {
  if [ -d "$2" ]; then
    rm -rf "$2"
  fi
  git clone "$1" "$2"
  info "cloning $1 to $2"
}

warn "Symlinking files"

# install .gitconfig
# install .zshrc
# install .tmux.conf
# install init.lua "$HOME/.config/nvim/init.lua"
# install plugins.lua "$HOME/.config/nvim/lua/plugins.lua"
install alacritty.toml "$HOME/.config/alacritty/alacritty.toml"
# install base.vim "$HOME/base.vim"
# install .gitattributes

# warn "Installing misc deps"

# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

warn "Running misc commands"

# $(which vim) +PlugUpdate +qall
# if command -v nvim; then
#   $(which nvim) +PlugUpdate +qall
# fi
