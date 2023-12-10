# Start tmux on default (https://unix.stackexchange.com/a/113768)
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] \
  && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$NOTMUX" ] \
  && [ -z "$INTELLIJ_ENVIRONMENT_READER" ] \
  && [ "$__CFBundleIdentifier" != "com.jetbrains.intellij" ] \
  && [ -z "$SSH_CONNECTION" ] \
  && [ "$TERM_PROGRAM" != "vscode" ]
then
  exec tmux
  #tmux
fi

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
