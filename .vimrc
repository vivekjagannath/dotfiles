set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set nowrap

set shiftwidth=4
set tabstop=4
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch

set wildmenu
set wildmode=list:longest
set wildignore=*.doc,*.jpg,*.png,*.pdf,*.pyc,*.img,*.xlsx

call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe'
Plug 'mbbill/undotree'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'jiangmiao/auto-pairs'
call plug#end()

colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_enable_diagnostic_signs=0

let mapleader = " "

nnoremap n nzz
nnoremap N Nzz
nnoremap Y y$

vnoremap <C-c> "+y
map <C-p> "+P

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>ut :UndotreeToggle<CR>
nnoremap <buffer> <F5> :w<CR> :!clear && python3 %
