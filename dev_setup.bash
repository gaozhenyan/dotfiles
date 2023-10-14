#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

if ! which curl >/dev/null; then
  sudo apt install -y git build-essential wget curl zsh
fi

function git_config() {
  git config --global user.name  gaozhenyan
  git config --global user.email gaozhenyan@hotmail.com
  git config --global alias.co checkout
  git config --global alias.br branch
  git config --global alias.ci commit
  git config --global alias.st status
  git config --global alias.unstage 'reset HEAD --'
  git config --global alias.last 'log -1 HEAD'
  git config --global alias.visual '!gitk'
  git config --global push.default simple
}

git_config

export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"

if ! which brew >/dev/null; then
  git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git brew-install
  NONINTERACTIVE=1 /bin/bash brew-install/install.sh
  rm -rf brew-install
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
fi


if ! which nvim >/dev/null; then
  brew install neovim fd ripgrep tmux zsh conan
fi

if [ ! -e $HOME/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh dir found, skipped"
fi

if [ ! -e $HOME/.config/nvim ]; then
  git clone git@github.com:gaozhenyan/NvChad.git $HOME/.config/nvim
else
  echo "nvim config found, skipped"
fi

if [ ! -e $HOME/.config/tmux ]; then
  git clone git@github.com:gaozhenyan/.tmux.git $HOME/.config/tmux
else
  echo "tmux config found, skipped"
fi

