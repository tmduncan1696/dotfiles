# dotfiles

Personal dotfiles for Ubuntu setup. Repo contains various environment configurations that I use across machines.

## Included Configs

- **Bash**
  .bashrc file

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

Then run the setup script:

```
cd dotfiles
chmod +x setup.sh
./setup.sh
```

The setup script updates Ubuntu and installs `stow` if it isn't already on the system.
Then uses stow to symlink all the config files in their correct locations.
