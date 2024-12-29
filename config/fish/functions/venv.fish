function venv
  set -f root (git rev-parse --show-toplevel 2>/dev/null)
  if test "$status" -ne "0"; set root .; end

  set -f venv_dir_default "$root/.venv"
  set -f venv_dirs "$venv_dir_default" "$root/venv"
  set -fe venv_dir_found

  for venv_dir in $venv_dirs
    if test -d "$venv_dir"
      set -f venv_dir_found "$venv_dir"
    end
  end

  if test -z "$venv_dir_found"
    python3 -m venv "$venv_dir_default"
    set -f venv_dir_found "$venv_dir_default"
  end

  . "$venv_dir_found/bin/activate.fish"
end
