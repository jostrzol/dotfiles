if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind \e\[3\;5~ kill-word
bind \b backward-kill-word
# search on tab
bind \t complete-and-search
bind -k btab complete

starship init fish | source
pyenv init - | source

abbr vi $VISUAL
abbr svi sudoedit
abbr config cd $HOME/dotfiles '&&' $VISUAL
abbr gcmsg git commit -m 
abbr ls exa
abbr ll exa -la
abbr l exa -la
abbr j just
abbr --set-cursor b 'nautilus >/dev/null 2>&1 % & disown'
abbr pacman-sizes 'expac "%n %m" -l"\n" -Q $(pacman -Qq) | sort -rhk 2 | numfmt --to=iec-i --field=2 --format="%.3f" | less'
abbr gcm git checkout (__git.default_branch)
abbr gcd 'cd "$(git rev-parse --show-toplevel)"'
abbr o xdg-open
abbr yt800 yt -q 800
