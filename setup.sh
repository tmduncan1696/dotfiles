#!/usr/bin/env bash

install-if-not-exist() {
	if dpkg -s "$1"	&>/dev/null; then
		PKG_EXIST=$(dpkg -s "$1" | grep "install ok installed")
		if [[ -n "$PKG_EXIST" ]]; then 
			return
		fi
	fi
	apt install "$1" -y
}

sudo apt update
install-if-not-exist stow

for pkg in $(ls -d */ | cut -f1 -d'/'); do
	stow "$pkg"
done
