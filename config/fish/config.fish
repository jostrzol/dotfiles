if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
pyenv init - | source

abbr vi $VISUAL
abbr config cd $HOME/dotfiles '&&' $VISUAL
abbr gcmsg git commit -m 
abbr ls exa
abbr ll exa -la
abbr l ll
abbr j just
abbr pacman-sizes 'expac "%n %m" -l"\n" -Q $(pacman -Qq) | sort -rhk 2 | numfmt --to=iec-i --field=2 --format="%.3f" | less'
