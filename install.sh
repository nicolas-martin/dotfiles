#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
  # Only show info in debug mode
  if [ "${DEBUG:-0}" = "1" ]; then
    echo -e "${BLUE}ℹ️  $@${NC}"
  fi
}

warn() {
  echo -e "${RED}⚠️  $@${NC}"
}

success() {
  echo -e "${GREEN}✅ $@${NC}"
}

install() {
  local src="$(pwd)/$1"
  local dst="$2"
  
  if [ ! -e "$src" ]; then
    warn "Source file $src does not exist. Skipping."
    return
  fi

  # Check if symlink already exists and points to the right place
  if [ -L "$dst" ]; then
    current_target="$(readlink "$dst")"
    if [ "$current_target" = "$src" ]; then
      info "Symlink already exists and is correct: $dst → $src"
      return
    fi
  fi

  # Create parent directory and remove existing file/symlink
  mkdir -p "$(dirname "$dst")"
  [ -e "$dst" ] && rm -f "$dst"

  if ! ln -sf "$src" "$dst"; then
    warn "Failed to link $src to $dst"
  else
    success "Linked $src → $dst"
  fi
}

gitstall() {
  if [ -d "$2" ]; then
    rm -rf "$2"
  fi
  git clone "$1" "$2"
  info "Cloning $1 to $2"
}

DEST_DIR="${XDG_CONFIG_HOME:-/Users/nma}"
CONFIG_DIR="${XDG_CONFIG_HOME:-/Users/nma/.config}"
LOCAL_DIR="${XDG_DATA_HOME:-/Users/nma/.local}"

echo -e "\n${YELLOW}🔧 Starting installation...${NC}\n"

# Clean up destination directories first
echo -e "${BLUE}🧹 Cleaning up old files...${NC}"
rm -rf "${CONFIG_DIR}/nvim/lua/"*
mkdir -p "${CONFIG_DIR}/nvim/lua"
rm -rf "${LOCAL_DIR}/bin/"*
mkdir -p "${LOCAL_DIR}/bin"

# General dotfiles
echo -e "\n${BLUE}📄 Installing dotfiles...${NC}"
install .gitconfig "${DEST_DIR}/.gitconfig"
install .zshrc "${DEST_DIR}/.zshrc"
install .tmux.conf "${DEST_DIR}/.tmux.conf"
install alacritty.toml "${CONFIG_DIR}/alacritty/alacritty.toml"

# Neovim configuration
echo -e "\n${BLUE}📝 Setting up Neovim...${NC}"
install init.lua "${CONFIG_DIR}/nvim/init.lua"

# Install all .lua files from lua directory
find lua -name "*.lua" -type f | while read -r file; do
    relative_path=${file#lua/}
    install "$file" "${CONFIG_DIR}/nvim/lua/$relative_path"
done

# Install bin files to ~/.local/bin
echo -e "\n${BLUE}🔨 Installing binaries...${NC}"
mkdir -p "${LOCAL_DIR}/bin"
find bin -type f | while read -r file; do
    install "$file" "${LOCAL_DIR}/bin/$(basename "$file")"
done

echo -e "\n${GREEN}✨ Installation complete! Everything is set up and ready to go!${NC}\n"
