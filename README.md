# dotfiles

Personal dotfiles for Ubuntu setup. Repo contains various environment configurations that I use across machines.

## Included Configs

- **Bash**
  .bashrc file

- **Git**
  .gitconfig file

- **LazyGit**
  Custom lazygit configuration

- **Neovim**
  Full neovim setup including plugins

- **tmux**
  tmux configuration

## Installation

Clone the repo into your home directory:

```
git clone https://github.com/tmduncan1696/dotfiles.git
```

The following tools are needed for the dotfiles to run properly:
* stow
* nvim
* fd
* ripgrep
* lazygit

Once tools are installed, run the setup script:

```
cd dotfiles
chmod +x setup.sh
./setup.sh
```

The setup script does the following:
- Installs `oh-my-posh` and the meslo Nerd Font if it isn't already on the system 
- Uses `stow` to symlink all the config files in their correct locations

Once this is complete, be sure to update the font for the terminal emulator being used
