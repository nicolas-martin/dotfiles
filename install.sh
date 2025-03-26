#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

yellow()  { printf "%b\n" "${YELLOW}$*${NC}"; }
blue()    { printf "%b\n" "${BLUE}$*${NC}"; }
red()     { printf "%b\n" "${RED}$*${NC}"; }
green()   { printf "%b\n" "${GREEN}$*${NC}"; }

install() {
	local src="$(pwd)/$1"
	local dst="$2"

	if [ ! -e "$src" ]; then
		red "⚠️  Missing: $1"
		return
	fi

	if [ -L "$dst" ]; then
		local current_target
		current_target="$(readlink "$dst")"
		if [ "$current_target" = "$src" ]; then
			green "✓ $(basename "$dst") already linked"
			return
		fi
	fi

	mkdir -p "$(dirname "$dst")"
	[ -e "$dst" ] && rm -f "$dst"

	if ln -sf "$src" "$dst"; then
		green "✓ Linked $(basename "$dst")"
	else
		red "⚠️  Failed to link $(basename "$dst")"
	fi
}

gitstall() {
	[ -d "$2" ] && rm -rf "$2"
	git clone "$1" "$2"
	echo "Cloned $1 to $2"
}

HOME_DIR="${XDG_CONFIG_HOME:-/Users/nma}"
CONFIG_DIR="${XDG_CONFIG_HOME:-/Users/nma/.config}"
LOCAL_DIR="${XDG_DATA_HOME:-/Users/nma/.local}"
NVIM_DIR="${CONFIG_DIR}/nvim"
BIN_DIR="${LOCAL_DIR}/bin"

yellow $'🔧 Starting installation'

blue $'\n🧹 Cleaning up'
rm -rf "${NVIM_DIR}"*
mkdir -p "${NVIM_DIR}"
blue "• Reset nvim dir"

rm -rf "${BIN_DIR}/"*
mkdir -p "${BIN_DIR}"
blue "• Reset bin dir"

blue $'\n📄 Installing dotfiles'
find dotfiles -type f | while read -r file; do
	install "$file" "${HOME_DIR}/${file#dotfiles/}"
done

blue $'\n📄 Installing .config files'
find .config -type f | while read -r file; do
	install "$file" "${CONFIG_DIR}/${file#.config/}"
done

blue $'\n📄 Installing nvim config'
find nvim -name "*.lua" -type f | while read -r file; do
	install "$file" "${NVIM_DIR}/${file#nvim}"
done

blue $'\n📄 Installing binaries'
find bin -type f | while read -r file; do
	install "$file" "${BIN_DIR}/$(basename "$file")"
done

green $'\n✨ Installation complete'

