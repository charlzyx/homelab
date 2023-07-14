" ------------------------------------------------------------
" -- Layer base config --------------------------------------------
" ------------------------------------------------------------
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let mapleader=' '
set hlsearch
set number
set scrolloff=8
set expandtab
set sw=2
set tabstop=2
set softtabstop=2
set nocompatible               " Be iMproved
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
" ------------------------------------------------------------
" -- Layer key mapping ---------------------------------------
" ------------------------------------------------------------
" Vim Settings
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;
nnoremap ? *
vnoremap ? *
nnoremap * ?
vnoremap * ?
nnoremap U <c-r>
vnoremap v <esc>
nnoremap Y "+y<cr>
vnoremap Y "+y<cr>
nnoremap P "+p<cr>
vnoremap P "+p<cr>
imap jj <esc>
imap jk <esc>
nnoremap <leader>w <c-w>
nnoremap <leader>wd :q<cr>
nnoremap <leader>jj :jumps<cr>
nnoremap <leader>mm :marks<cr>
