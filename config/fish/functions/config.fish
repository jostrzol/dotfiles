function config -d 'configure dotfiles'
    argparse --min-args 0 --max-args 1 -- $argv
    or return

    if test "$(count $argv)" -eq 1
        set -f type "$argv[1]"
    else
        set -f type
    end

    set -f file ""
    set -f dir "$HOME/dotfiles"

    switch "$type"
        case lvim
            set -f file "./config/lvim/autoconf/plugins-custom.lua"
        case {n,}vim
            set -f file "./config/nvim/lua/plugins/astrocore.lua"
        case fish
            set -f file "./config/fish/config.fish"
        case kitty
            set -f file "./config/kitty/kitty.conf"
        case local
            set -f dir "$HOME/dotfiles-local"
    end

    set -f prev_dir "$PWD"
    cd "$dir"

    if test -n "$file"
        $VISUAL "$file"
    else
        $VISUAL
    end

    cd "$prev_dir"
end
