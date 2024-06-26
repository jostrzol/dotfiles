" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" Set incompatible with original vi for more usability
set nocompatible

" Encoding
set encoding=utf-8

" Leader to backtick
let mapleader = "`"
" LocalLeader to equals
let maplocalleader = "="

" Set escape timeout
set timeout timeoutlen=1000 ttimeout ttimeoutlen=5

" Map Y to yank till end of line
nnoremap Y y$

" TODO: fix:
" uncommented will slow ESC to timeoutlen instead of ttimeoutlen
" find a way to avoid it
"
" Map option+backspace/arrows to work for whole words
" inoremap <Esc><BS> <C-w>
" inoremap <Esc>[1;5D <C-o>b
" inoremap <Esc>[1;5C <C-o>e

" Bar cursor in insert mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" Tab settings
set expandtab       " Enter spaces when tab is pressed
set textwidth=100   " Break lines when line length passes this threshold
set colorcolumn=+1  " Highlight last column
set tabstop=2       " Use 2 spaces to represent tab
set softtabstop=2
set shiftround      " Round indent to multiple of 'shiftwidth'
set shiftwidth=2    " Number of spaces to use for autoindent
set autoindent      " Copy indent from currenct line when starting a new line
set nojoinspaces    " Use one space, not two, after punctuation.

" General settings
set updatetime=100
set history=50
set scrolloff=5     " Minimal distance from cursor to edge of screen
set ruler           " Show the cursor position all the time
set showcmd         " Display incomplete commands
set incsearch       " Do incremental searching
set laststatus=2    " Always display the status line
set autowrite       " Automatically :write before running commands
set hlsearch        " Highlight searches
set modelines=0     " Disable modelines as a security precaution
set undofile        " Remember undo history between sessions
set nomodeline

" Search settings
set ignorecase      " Ignore case in search patterns
set smartcase       " Don't ignore case if upper case in search

" Misc
set backspace=indent,eol,start            " Make backspace more powerfull
set termguicolors                         " Enable 24-bit color mode
set list listchars=tab:»·,trail:·,nbsp:·  " Display extra whitespace
set nrformats+=alpha                      " make <C-a> work for letters

" Save swap, backup and undo files in a special location <https://stackoverflow.com/a/15317146>
for dir in ["backup", "swap", "undo"]
  let dirpath = expand(stdpath("config") . dir)
  if !isdirectory(dirpath)
    call mkdir(dirpath, "p")
  endif
endfor
" disable backup because of issue with COC: https://github.com/neoclide/coc.nvim/issues/649
" set backupdir=~/.vim/backup//
set nobackup
set nowritebackup
let &directory=(stdpath("config") . 'swap')
let &undodir=(stdpath("config") . 'undo')

" Enable mouse handling
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Source bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.config/nvim/bundles.vim
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile
    \ aliases.local,
    \zshenv.local,zlogin.local,zlogout.local,zshrc.local,zprofile.local,
    \*/zsh/configs/*
    \ set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
  autocmd BufRead,BufNewFile *.wgsl set filetype=wgsl
  autocmd BufRead,BufNewFile Justfile set filetype=just
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

  " if !exists(":Ag")
  "   command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  "   nnoremap \ :Ag<SPACE>
  " endif

  nnoremap \ :Ag<CR>
endif

" Numbers
set number
set numberwidth=5

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<Space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set tags for vim-fugitive
set tags^=.git/tags

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" This unsets the "last search pattern" register by hitting return and resets GitGutter indicators
nnoremap <silent><CR> :noh<CR> :GitGutter<CR><CR>

" Start writing substitute command with the word under the cursor
vnoremap <Leader>s "0y :%s/<C-R>0/

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" We need this for plugins like Syntastic and vim-gitgutter which put symbols
" in the sign column.
hi clear SignColumn

" ===== Plugin-Specific Settings ======================================

" ----- FZF -------------------------------------------
" Map Ctrl + p to FZF files
nnoremap <c-p> :Files<cr>
" Map Alt + p to FZF buffers
nnoremap <Esc>p :Buffers<cr>

" ----- vim-test mappings -----------------------------
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>o :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" ----- altercation/vim-colors-solarized settings -----
" Toggle this to "light" for light colorscheme
set background=dark

" Set the colorscheme
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

" Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

" Use the solarized theme for the Airline status bar
let g:airline_theme='base16_gruvbox_dark_hard'

" ----- puremourning/vimspector -----
" Human mappings (see https://github.com/puremourning/vimspector#human-mode)
let g:vimspector_enable_mappings = 'HUMAN'

" Balloon eval
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

" Navigating stack
nmap <LocalLeader><F11> <Plug>VimspectorUpFrame
nmap <LocalLeader><F12> <Plug>VimspectorDownFrame
nmap <LocalLeader>B     <Plug>VimspectorBreakpoints
nmap <LocalLeader>D     <Plug>VimspectorDisassemble

" ----- jistr/vim-nerdtree-tabs -----
let NERDTreeMinimalUI=1
let NERDTreeMinimalMenu=1
" Open/close NERDTree Tabs with ,m
nmap <silent> ,m :NERDTreeTabsToggle<CR>
" Reveal file in tree with ,n
nmap <silent> ,n :NERDTreeFind<CR>

" To have NERDTree always open on startup
"let g:nerdtree_tabs_open_on_console_startup = 1
" File filters
let NERDTreeIgnore = [
  "\ Python files
  \ '\.pyc$',
  \ '^__pycache__$[[dir]]',
  "\ Gradle files
  \ '^gradlew$',
  \ '^gradlew.bat',
  \ '^gradle$[[dir]]',
  \ '^bin$[[dir]]',
  \ '^build$[[dir]]',
  "\ Misc files
  \ '\.o$',
  \ '^tags$[[file]]',
  \ '^node_modules$',
  \ ]

" nerdtree-git section
let g:NERDTreeGitStatusUseNerdFonts = 1

" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END


" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1


" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)


" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1


" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ----- jez/vim-superman settings -----
" better man page support
noremap K :SuperMan <cword><CR>

" ----- tibabit/vim-templates settings -----
let g:tmpl_search_paths = ['~/dotfiles/vim-templates']

" ----- neoclide/coc.nvim settings -----
" Automatically install these extensions
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-sh',
  \ 'coc-tsserver',
  \ 'coc-diagnostic',
  \ 'coc-vimlsp',
  \ 'coc-vimtex'
  \ ]
" TODO: check out:
" * 'coc-git'

" TODO: think of something more like in VSCode
" (so that cursor stops on the last occurence, not the next)
" HINT: https://github.com/neoclide/coc.nvim/wiki/Multiple-cursors-support
" Map ctrl+s to make new cursors
nnoremap <silent> <C-s> <Plug>(coc-cursors-word)*:nohlsearch<CR>
xnoremap <silent> <C-s> y/\V<C-r>=escape(@",'/\')<CR><CR>NgN<Plug>(coc-cursors-range)n:nohlsearch<CR>gn

" Make <Tab> to accept selected completion item
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"

" Make <CR> notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#pum#visible() ? coc#pum#stop() : coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#pum#visible() ? coc#pum#stop() : coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gu <Plug>(coc-references-used)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Map alt+f to format the current buffer
nnoremap <silent><Esc>f :call CocActionAsync('format')<cr>

" Map alt+o to organize imports
nnoremap <silent><Esc>o :call CocActionAsync('runCommand', 'editor.action.organizeImport')<cr>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ===== neoclide/coc-snippets =========================================
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" ===== fatih/vim-go ==================================================
" There are troubles for this to work on WSL: -remote=auto expects
" systemd to create /run/user/$uid folder, but on WSL 1.0.3 it didn't work.
"
" Steps to fix:
" 1. Upgrade WSL to 1.1.0+ (https://askubuntu.com/a/1442827)
"   a. Try: wsl.exe --update && wsl.exe --version
"   b. If doesn't work then download .msixbundle from https://github.com/microsoft/WSL/releases/tag/1.1.0
"      and install using: Add-AppxPackage {FILE}
" 2. Enable systemd user linger: sudo loginctl enable-linger {USERNAME} (https://github.com/microsoft/WSL/issues/8842)
" 3. wsl.exe --shutdown
"
" Now --remote=auto should work again
let g:go_gopls_options = ["-remote=auto"]

" disable mappings from vim-go, use coc-go mappings instead
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" ===== lervag/vimtex config ==========================================
let g:vimtex_compiler_method = 'tectonic'

let g:vimtex_view_general_viewer = 'sumatraPDF.exe'
let g:vimtex_view_general_options = '-reuse-instance @pdf'

let g:vimtex_compiler_tectonic = {
  \ 'build_dir' : './build',
  \ 'options' : [
  \   '--keep-logs',
  \   '--synctex'
  \ ],
  \}

let g:vimtex_quickfix_ignore_filters = [
  \ 'Underfull',
  \ 'Overfull',
  \]

" ===== Custom commands, aliases ======================================
" Redir https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd, rng, start, end)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    let cmd = a:cmd =~' %'
      \ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
      \ : matchstr(a:cmd, '^!\zs.*')
    if a:rng == 0
      let output = systemlist(cmd)
    else
      let joined_lines = join(getline(a:start, a:end), '\n')
      let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
      let output = systemlist(cmd . " <<< $" . cleaned_lines)
    endif
  else
    redir => output
    execute a:cmd
    redir END
    let output = split(output, "\n")
  endif
  vnew
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, output)
endfunction

" Close all buffers but he selected one
" See: https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one#comment86214068_42071865
command! BufOnly silent! execute "%bd|e#|bd#"

" This command definition includes -bar, so that it is possible to "chain" Vim commands.
" Side effect: double quotes can't be used in external commands
command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
" Side effect: Vim commands can't be "chained".
command! -nargs=1 -complete=command -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

" Alias for glog
command! Glog Git log --oneline --decorate --graph
command! Gloga Git log --oneline --decorate --graph --all

" Alias for reloading config
command! Reload exec 'source' stdpath("config") . "/init.vim"

" Alias for restarting, keeping the current file open
command! Restart exec '!echo' expand("%") expand(">/tmp/nvim-restart-$PPID") | cq 70

" Build go cmd
function! GoBuildCmd()
  let output = system("go list -f '{{.Name}} {{.ImportPath}}' ./...")
  for line in split(output, "\n")
    let [package, importpath] = split(line, " ")
    if package == "main"
      exec "GoBuild" importpath
    endif
  endfor
endfunction

" Aliast for vim-go
command! GoBuildCmd call GoBuildCmd()
command! GoBuildAll exec 'GoBuild' getcwd() . "/..."
command! GoTestAll exec 'GoTest' getcwd() . "/..."
