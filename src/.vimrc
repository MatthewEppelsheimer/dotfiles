" User's Vim config

" NOTE RE CoC: WIP INSTALLATION/CONFIG!
"  Working my way through this:
" https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#add-some-configuration
" and:
" https://github.com/neoclide/coc.nvim#example-vim-configuration
" initially went down this path thanks to:
" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim#going-above-and-beyond-with-coc

" SYNTAX

" syntax highlighting
syntax on

" Rescan entire buffer when highlighting in JS, JSX, TS, and TSX files to avoid sync issues; has perf cost
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" COMMIT MESSAGE EDITING

" Enable spell checking and auto-wrapping
autocmd Filetype gitcommit setlocal spell textwidth=72


" BINDINGS

" Bind `:nohlsearch` cmd (remove current highlighting) to "/<spacebar>" key combo
nnoremap <leader><space> :nohlsearch<CR>

" Bind za cmd (open/close folds) to "<spacebar"
nnoremap <space> za

" Use tab for trigger completion with characters ahead and navigate, per CoC Readme
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" FEATURES

" More space for commands/messages
set cmdheight=2

" Highlight the cursor's line
set cursorline

" UTF-8 character encoding
set encoding=utf-8

" Make tabs insert spaces
set expandtab

" Enable cold folding
set foldenable

" Fold based on language syntax
set foldmethod=syntax

" Open most folds by default
set foldlevelstart=30

" Highlight search results
set hlsearch

" Begin highlighting as soon as you start typing for search
set incsearch

" Defer screen redrawing during tasks like running macros
set lazyredraw

" Disable backup files; some language servers have issues with these, per CoC Readme
set nobackup
set nowritebackup

" show line number
set number

" accept pasted-in content gracefully
set paste

" show column number
set ruler

" show command
set showcmd

" Always show signcolumn, avoid shifting text when diagnostics appear/resolve, per CoC Readme
if has("nvim-0.5.0") || has("path-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Make tab equivalent to 4 spaces
set tabstop=4

" Shorter updatetime (default is 4000ms) for better UX, per CoC Readme
set updatetime=300

" Set Vim's view options
set viewoptions=cursor,folds,slash,unix

" Command autocompletion
set wildmenu


" VIM-PLUG CONFIG
" https://github.com/junegunn/vim-plug

" Specify plugin dir
call plug#begin('~/.vim/plugged')

" TS syntax plugin
Plug 'leafgarland/typescript-vim'

" CoC language server
" https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" JS syntax plugin
Plug 'pangloss/vim-javascript'

" Save & re-open views e.g. so your cursor position and fold status is preserved
" Plug 'vim-scripts/restore_view.vim'
Plug 'https://github.com/vim-scripts/restore_view.vim'

" Initialize plugin system
call plug#end()

