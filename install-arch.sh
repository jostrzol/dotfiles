#!/usr/bin/env sh

# initialize submodules
git submodule update --init --recursive --remote

# ensure sudo is installed
if ! [ -x /usr/bin/sudo ]; then
  echo >&2 "sudo is required for the installation"
  exit 1
fi

# packages to install through pacman
set \
  git \
  base-devel \
  zsh \
  tmux \
  ctags \
  the_silver_searcher \
  fzf \
  cmake \
  python \
  npm \
  z \

# install the packages
sudo pacman -Sy "$@"

# install yay
if ! [ -x /usr/bin/yay ]; then
  (
    cd /tmp && \
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si
  )
fi

# packages to install through yay
set \
  rcm \
  tmux-plugin-manager \

# install the packages
yay -Sy "$@"

# install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# oh my zsh plugins to install
set \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting \
  Aloxaf/fzf-tab \
  paulirish/git-open \

# download the plugins
for plugin in "$@"; do
  (
    cd "$ZSH/custom/plugins" && \
      git clone "https://github.com/$plugin"
  )
done

# install dotfiles
env RCRC=$HOME/dotfiles/rcrc rcup
