function config -d 'configure dotfiles'
    argparse --min-args 0 --max-args 1 -- $argv
    if test "$(count $argv)" -eq 1
        set -f command "$argv[1]"
    else
        set -f command
    end

    set -f file ""

    switch "$command"
        case {l,}vim
            set -f file "./config/lvim/autoconf/plugins-custom.lua"
        case fish
            set -f file "./config/fish/config.fish"
        case kitty
            set -f file "./config/kitty/kitty.conf"
    end

    cd $HOME/dotfiles

    if test -n "$file"
        $VISUAL "$file"
    else
        $VISUAL
    end
end
