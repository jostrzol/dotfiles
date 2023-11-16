# Try loading ASDF from the regular home dir location
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
elif which brew >/dev/null &&
  BREW_DIR="$(dirname `which brew`)/.." &&
  [ -f "$BREW_DIR/opt/asdf/asdf.sh" ]; then
  . "$BREW_DIR/opt/asdf/asdf.sh"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

# cargo packages
PATH="$HOME/.cargo/bin:$PATH"

# go packages
PATH="$HOME/go/bin:$PATH"

# yarn packages
PATH="$HOME/.yarn/bin:$PATH"

# dotfiles
PATH="$HOME/.bin:$PATH"

# local
PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

export -U PATH
