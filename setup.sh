#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

PACKAGES=$(ls -d */ | cut -f 1 -d '/')

# Install package
# takes 1 argument: package to install
install-package() {
	PKG_EXIST=$(dpkg -s "$1" | grep "install ok installed")
	if [[ -n "$PKG_EXIST" ]]; then 
		echo "$1 is already installed"
		return
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

copy-home() {
	local files=$(find $1 -type f)
	while IFS= read -r file; do
		cp $file $(sed -n "s|[^/]|$HOME|p" <<< $file)
	done <<< $files
}

# Stow packages
# Args:
#	Packages to create symlinks for
stow-packages() {
	if [[ "$OSTYPE" = "linux-gnu" ]]; then
		while IFS= read -r pkg; do
			stow "$pkg"
		done <<< $1
	elif [[ "$OSTYPE" = "cygwin" || "$OSTYPE" = "msys" ]]; then
		while IFS= read -r pkg; do
			copy-home "$pkg"
		done <<< $1
	else
		echo "Operating System $OSTYPE not implemented" >&2
	fi
}

main() {
	# If running on Linux
	if [[ "$OSTYPE" = "linux-gnu" ]]; then
		# Install stow if it doesn't exist
		install-package stow

		# Install Neovim
		install-package neovim
	# if running on Windows
	elif [[ "$OSTYPE" = "cygwin" || "$OSTYPE" = "msys" ]]; then
		# Install Neovim
		winget install Neovim.Neovim
	else
		echo "Operating System $OSTYPE not implemented" >&2
	fi

	# Stow packages
	create-backups $PACKAGES
	stow-packages $PACKAGES

	# Setup Neovim
	setup-nvim

	# Install and setup oh-my-posh
	install-posh

	# Reload .bashrc
	exec bash
}

main
