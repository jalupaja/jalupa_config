set showmatch
set ignorecase
set hlsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set number
set relativenumber
set encoding=utf8

syntax on
filetype plugin indent on
filetype plugin on

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdcommenter'     " commend Keybindings
Plug 'jiangmiao/auto-pairs'         " automatic brackets
Plug 'ctrlpvim/ctrlp.vim'           " File Search via CTRL-P
Plug 'sbdchd/neoformat'             " auto formatter
Plug 'jacoborus/tender.vim'         " colorscheme

" ---
call plug#end()

" ----------------------
"  change <leader> to space
let mapleader=" "

" -----------------------
"  remap keys
inoremap ii <Esc> " map ii in insertmode to Escape
tnoremap <Esc> <C-\><C-n> " allow ESC in terminal mode
vmap <Leader>y "+y " map copy to system clipboard
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader>f :Neoformat<CR>

" colorscheme
colorscheme tender
hi Normal guibg=NONE ctermbg=NONE
