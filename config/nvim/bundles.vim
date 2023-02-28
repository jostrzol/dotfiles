let g:has_async = v:version >= 800 || has('nvim')

call plug#begin('~/.vim/bundle')

" ----- Making Vim look good ------------------------------------------
Plug 'lambdalisue/nerdfont.vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Make tmux look like vim-airline (read README for extra instructions)
Plug 'edkolev/tmuxline.vim'

" ----- Navigation ----------------------------------------------------
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Directory navigator
Plug 'scrooloose/nerdtree'
" Directory navigator as an (more) independent tab
Plug 'jistr/vim-nerdtree-tabs'
" Directory navigator git status
Plug 'Xuyuanp/nerdtree-git-plugin'
" Directory icons for NERDTREE and more
Plug 'ryanoasis/vim-devicons'
" Jump between header and source file
Plug 'vim-scripts/a.vim'
" Navigating though projects
Plug 'tpope/vim-projectionist'
" Delete buffers without exit
Plug 'qpkorr/vim-bufkill'

" ----- Tag plugins ---------------------------------------------------
" Automatically generate tags
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
" Tab for viewing tags
Plug 'majutsushi/tagbar'

" ----- Vim as a programmer's text editor -----------------------------
" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Multiple cursors
Plug 'terryma/vim-multiple-cursors'
" Debugging
Plug 'puremourning/vimspector'
" Easily run tests
Plug 'janko-m/vim-test'
" Easily comment sections of code
Plug 'vim-scripts/tComment'
" Easily surround chunks of text
Plug 'tpope/vim-surround'
" Autimatically insert the closing keywords (e.g. if -> fi)
Plug 'tpope/vim-endwise'
" Automatically insert the closing HTML tag
Plug 'vim-scripts/HTML-AutoCloseTag'
" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" ----- Working with Git ----------------------------------------------
" Support for git humps
Plug 'airblade/vim-gitgutter'
" Support for git
Plug 'tpope/vim-fugitive'
" Support for GitHub
Plug 'tpope/vim-rhubarb'

" ----- Other text editing features -----------------------------------
" Auto closing
Plug 'Raimondi/delimitMate'
" %S substitution and more
Plug 'tpope/vim-abolish'

" ----- man pages, tmux -----------------------------------------------
Plug 'jez/vim-superman'
Plug 'christoomey/vim-tmux-navigator'

" ----- Language plugins -----------------------------------------------
Plug 'udalov/kotlin-vim'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'ekalinin/Dockerfile.vim'
Plug 'lervag/vimtex'
Plug 'neovimhaskell/haskell-vim'

" ----- Shell plugins --------------------------------------------------
" Zsh syntax highlighting in vim
Plug 'zsh-users/zsh-syntax-highlighting'
" Shell utilities from inside of vim
Plug 'tpope/vim-eunuch'

" ----- Extras/Advanced plugins ----------------------------------------
" Highlight and strip trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" Align CSV files at commas, align Markdown tables, and more
Plug 'godlygeek/tabular'
" Don't complain on writing to inexistant dirs
Plug 'pbrisbin/vim-mkdir'
" Dunno, sth with syntax, but README is very sparse
Plug 'slim-template/vim-slim'
" Repeat (.) works for plugin commands
Plug 'tpope/vim-repeat'
" Templates
Plug 'tibabit/vim-templates'
" Swap pieces of text
Plug 'tommcdo/vim-exchange'

call plug#end()
