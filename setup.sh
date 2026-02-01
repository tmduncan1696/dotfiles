#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

PACKAGES=$(ls -d */ | cut -f 1 -d '/')

# Install package
# takes 1 argument: package to install
install-package() {
	if dpkg -s "$1"	&>/dev/null; then
		PKG_EXIST=$(dpkg -s "$1" | grep "install ok installed")
		if [[ -n "$PKG_EXIST" ]]; then 
			echo "$1 is already installed"
			return
		fi
	fi

	echo "Installing $1"
	apt install "$1" -y
}

# Install oh-my-posh
install-posh() {
	if command -v oh-my-posh >/dev/null 2>&1; then
		echo "oh-my-posh is already installed"
		return
	fi

	echo "Installing oh-my-posh"
	curl -s https://ohmyposh.dev/install.sh | bash -s

	echo "Installing meslo Nerd Font"
	oh-my-posh font meslo
}

# Setup Neovim
# Installs Plug and installs plugins
setup-nvim() {
	echo "Installing Vim Plugged"
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

	nvim +PlugInstall +qall
}

# Create backup files
# Args:
#	Packages to create backups for if the configs are not symlinks
create-backups() {
	while IFS= read -r pkg; do
		local files=$(find "$pkg" -type f | sed -n "s|$pkg|$HOME|p")
		while IFS= read -r file; do
			if [[ -f $file ]]; then
				mv "$file" "$file.bak"
			fi
		done
	done <<< $1
}

# Stow packages
# Args:
#	Packages to create symlinks for
stow-packages() {
	while IFS= read -r pkg; do
		stow "$pkg"
	done <<< $1
}

# Install stow if it doesn't exist
install-package stow

# Stow packages
create-backups $PACKAGES
stow-packages $PACKAGES

# Install and setup Neovim
install-package nvim
setup-nvim

# Install and setup oh-my-posh
install-posh-if-not-exist
exec bash
