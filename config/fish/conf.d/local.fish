set -l fish_config_local "$HOME/.config/fish.local/"

if not test -d "$fish_config_local"; return; end

for file in "$fish_config_local/conf.d/"*
  . $file
end
