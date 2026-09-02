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
    zathura \
    zathura-pdf-mupdf \
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
    zathura \
    zathura-pdf-mupdf \
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
ln -sfn "$SCRIPT_DIR/zathura" "$HOME/.config/zathura"

# Install scripts
mkdir -p "$HOME/.local/bin"
ln -sfn "$SCRIPT_DIR/scripts/omarchy-list-third-party-plugins" "$HOME/.local/bin/omarchy-list-third-party-plugins"

# Make zsh the default shell.
chsh -s "$(command -v zsh)"

# Install Omarchy plugins.
if command -v omarchy >/dev/null 2>&1; then
  read -r -p "Install Omarchy plugins? [Y/n] " response
  if [[ ! "$response" =~ ^[Nn]$ ]]; then
    for plugin in \
      https://github.com/bobby-nicholas/omaland.git
      https://github.com/clipbasket/clipbasket-omarchy.git
      https://github.com/crmne/omarchy-hyprmoncfg.git
      https://github.com/kvm404/omarchy-laser-pointer.git
      https://github.com/SirJul1337/omarchy-lock-explorer.git
      https://github.com/tallsam/omarchy-navbar-cat
      https://github.com/jankeesvw/omarchy-notification-center.git
      https://github.com/jesseburlamaque/omarchy-find
      https://github.com/fross100/omaplug.git
      https://github.com/RishabhRD/recurring-reminders.git
      https://github.com/robzolkos/omarchy-github.git
      https://github.com/tmn73/omarchy-calendar
      https://github.com/niraletter/vitals
    do
      omarchy plugin add "$plugin" --enable
    done
  fi
fi
