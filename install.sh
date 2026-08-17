#!/usr/bin/env bash

set -e

# Absolute path of install.sh
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Install required packages.
if command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed \
    fzf \
    ranger \
    tmux \
    neovim \
    zsh \
    curl \
    git
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y \
    fzf \
    ranger \
    tmux \
    neovim \
    zsh \
    curl \
    software-properties-common

  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt update
  sudo apt install -y git
else
  echo "Unsupported package manager."
fi

# Install Oh My Zsh.
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install custom Oh My Zsh plugins.
for plugin in \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  zsh-history-substring-search
do
  if [[ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]]; then
    git clone "https://github.com/zsh-users/$plugin" \
      "$ZSH_CUSTOM/plugins/$plugin"
  fi
done

# Install Zsh configuration.
ln -sfn "$SCRIPT_DIR/zsh/init.zsh" "$HOME/.zshrc"
touch "$HOME/.paths.zsh"

# Install custom app configs.
mkdir -p "$HOME/.config"
ln -sfn "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
ln -sfn "$SCRIPT_DIR/tmux" "$HOME/.config/tmux"

# Make zsh the default shell.
chsh -s "$(command -v zsh)"

# Install Omarchy plugins.
if command -v omarchy >/dev/null 2>&1; then
  read -r -p "Install Omarchy plugins? [Y/n] " response
  if [[ ! "$response" =~ ^[Nn]$ ]]; then
    for plugin in \
      https://github.com/RishabhRD/omarchy-window-opacity \
      https://github.com/RishabhRD/recurring-reminders \
      https://github.com/robzolkos/omarchy-github \
      https://github.com/Shavanced/omarchy-notification-center-plugin \
      https://github.com/niraletter/vitals
    do
      omarchy plugin add "$plugin" --enable
    done
  fi
fi
