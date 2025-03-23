#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

yellow() {
	echo -e "${YELLOW}$@${NC}"
}

blue() {
	echo -e "${BLUE}$@${NC}"
}

red() {
	echo -e "${RED}$@${NC}"
}

green() {
	echo -e "${GREEN}$@${NC}"
}

warn() {
	red "⚠️  $@"
}

success() {
	green "✅ $@"
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
			success "Symlink already exists and is correct: $dst → $src"
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
	echo "Cloning $1 to $2"
}

HOME_DIR="${XDG_CONFIG_HOME:-/Users/nma}"
CONFIG_DIR="${XDG_CONFIG_HOME:-/Users/nma/.config}"
LOCAL_DIR="${XDG_DATA_HOME:-/Users/nma/.local}"

yellow 🔧 Starting installation...

# Clean up destination directories first
blue 🧹 Cleaning up old files...
LUA_DIR="${CONFIG_DIR}/nvim/lua"
rm -rf "${LUA_DIR}"*
blue    🧹 Removing lua ${LUA_DIR}
mkdir -p ${LUA_DIR}
BIN_DIR="${LOCAL_DIR}/bin"
rm -rf "${BIN_DIR}/"*
blue    🧹 Removing bin ${BIN_DIR}
mkdir -p "${BIN_DIR}"

# General dotfiles
blue "\n📄 Installing dotfiles..."
install .gitconfig "${HOME_DIR}/.gitconfig"
install .zshrc "${HOME_DIR}/.zshrc"
install .tmux.conf "${HOME_DIR}/.tmux.conf"
install .yabairc "${HOME_DIR}/.yabairc"
install .skhdrc "${HOME_DIR}/.skhdrc"
install alacritty.toml "${CONFIG_DIR}/alacritty/alacritty.toml"

# Neovim configuration
blue "\n📝 Setting up Neovim..."
install init.lua "${CONFIG_DIR}/nvim/init.lua"

# Install all .lua files from lua directory
find lua -name "*.lua" -type f | while read -r file; do
	relative_path=${file#lua/}
	install "$file" "${CONFIG_DIR}/nvim/lua/$relative_path"
done

# Install bin files to ~/.local/bin
blue "\n🔨 Installing binaries..."
mkdir -p "${LOCAL_DIR}/bin"
find bin -type f | while read -r file; do
	install "$file" "${LOCAL_DIR}/bin/$(basename "$file")"
done

green "\n✨ Installation complete! Everything is set up and ready to go!"
