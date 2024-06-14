function venv
  set -f root (git rev-parse --show-toplevel 2>/dev/null)
  if test "$status" -ne "0"; set root .; end
  set -f venv_dir "$root/.venv"
  if not test -d "$venv_dir"
    python3 -m venv "$venv_dir"
  end
  . "$venv_dir/bin/activate.fish"
end
