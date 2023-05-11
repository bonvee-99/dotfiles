#!/bin/zsh

# install package via homebrew or apt
install_package() {
  if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
      echo "Missing brew"
      echo "Installing brew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Installing $1..."
    brew install "$1"
  elif [[ "$(uname)" == "Linux" ]]; then
    echo "This machine is running Linux."
    echo "Installing $1..."
    sudo apt-get update
    sudo apt install "$1" -y
  else
    echo "Unknown operating system."
    exit 1
  fi
}

install_package tmux
install_package git
install_package neovim
 
# kitty
echo "Installing kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/dotfiles/kitty ~/.config/kitty

# tpm/tmux
echo "Installing tpm and plugins..."
ln -s ~/dotfiles/tmux ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux run-shell '~/.tmux/plugins/tpm/bindings/install_plugins'

echo "Installing astrovim and linking user config..."
if [ ! -d ~/.config/nvim ]; then
  echo "Installing AstroNvim..."
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  ln -s ~/dotfiles/nvim/user ~/.config/nvim/lua/user
else
  echo "Nvim folder already exists"
fi

# i3
ln -s ~/dotfiles/i3 ~/.config/i3
ln -s ~/dotfiles/compton.conf ~/.config/compton.conf

# - font (CaskaydiaCove Nerd Font Mono SemiBold)

# zsh
# - oh my zsh 
# - powerlevel10k
