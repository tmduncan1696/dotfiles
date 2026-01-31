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

install-posh-if-not-exist() {
	if command -v oh-my-posh >/dev/null 2>&1; then
		return
	fi

	curl -s https://ohmyposh.dev/install.sh | bash -s

	oh-my-posh font meslo
}

install-if-not-exist stow
install-posh-if-not-exist

for pkg in $(ls -d */ | cut -f 1 -d '/'); do
	stow "$pkg"
done
