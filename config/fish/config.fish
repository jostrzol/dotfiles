if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
pyenv init - | source

abbr vi $VISUAL
abbr config cd $HOME/dotfiles '&&' $VISUAL
abbr gcmsg git commit -m 
