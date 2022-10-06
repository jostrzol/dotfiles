# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# change autosuggestion color to fit with solarized
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5a6f72"

# set dircolors
eval $(dircolors ~/.dircolors-solarized/dircolors.256dark)
