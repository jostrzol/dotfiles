function wrap-in-dir -d 'wrap the current directory in a folder of the given name'
  argparse --min-args 1 --max-args 1 -- $argv
  set -f dir "$argv[1]"
  mkdir "$dir"
  fd --exclude "$dir" --exec-batch mv '{}' "$dir"
end

