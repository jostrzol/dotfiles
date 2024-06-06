if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

abbr vi $VISUAL
abbr config cd $HOME/dotfiles '&&' $VISUAL
