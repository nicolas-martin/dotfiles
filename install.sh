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

# Create the target directory if it doesn't exist
mkdir -p "$HOME/.config/nvim/lua"

# Find all .lua files in the lua directory and install them
find lua -name "*.lua" -type f | while read -r file; do
    # Get the relative path within the lua directory
    relative_path=${file#lua/}
    # Create target directory if needed
    target_dir="$HOME/.config/nvim/lua/$(dirname "$relative_path")"
    # Install the file
    echo "Installing $file to $target_dir"
    install "$file" "$HOME/.config/nvim/lua/$relative_path"
done

# Uncomment these if you want to use them
# install base.vim "$HOME/base.vim"
# install .gitattributes

warn "Installation complete!"
