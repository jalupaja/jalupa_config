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
filetype plugin on
filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdcommenter'     " commend Keybindings
Plug 'jiangmiao/auto-pairs'         " automatic brackets
Plug 'ctrlpvim/ctrlp.vim'           " File Search via CTRL-P

" --- color schemes
Plug 'srcery-colors/srcery-vim'
Plug 'vim-airline/vim-airline'
" ---

Plug 'neoclide/coc.nvim', { 'branch': 'release' } " Syntax completion support
Plug 'pechorin/any-jump.vim'        " 
"Plug 'scrooloose/nerdtree'         " file explorer
"Plug 'vim/devicons'                " devicons for nerdtree
Plug 'kevinhwang91/rnvimr'          " ranger support
Plug 'sirver/ultisnips'             " autocomplete snippets
Plug 'skywind3000/asynctasks.vim'   " auto build, run stuff
Plug 'skywind3000/asyncrun.vim'
Plug 'sbdchd/neoformat'             " auto formatter
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'lervag/vimtex'                " LaTeX Support
call plug#end()

" ----------------------
" configure extra coc extensions. rest is in in coc-settings.json
let g:coc_global_extensions = ['coc-pyright', 'coc-cmake', 'coc-java', 'coc-powershell', 'coc-git', 'coc-html', 'coc-css', 'coc-tsserver', 'coc-json', 'coc-markdownlint']

" ----------------------
"  configure treesitter extensions
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "cmake", "java", "go", "python", "bash", "javascript" },
    highlight = { enable = true, },
    }
EOF

" ----------------------
"  change <leader> to space
let mapleader=" "

" -----------------------
"  use ranger as filemanager
let g:rnvimr_ex_enable = 1
nmap <leader>m :RnvimrToggle<CR>

" -----------------------
" changeany-jump config
let g:any_jump_disable_default_keybindings = 1
nnoremap <Leader>i :AnyJump<CR>

" -----------------------
" LaTeX config
" set shellslash " for win32
let g:tex_falvor='latex'
let g:vimtex_indent_enabled = 1
let g:vimtex_complete_recursive_bib = 1
let g:vimtex_complete_close_baces = 1
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 1
let g:vimtex_view_method = 'zathura'    " use zathura as build in viewer method
"let g:vimtex_view_general_viewer = 'okular' " use generic interface
"let g:vimtex_view_general_viewer = '--unique file:@pdf/#src:@line@tex'
let g:vimtex_latexmk_continuous = 1     " automatic compilation on save 

" -----------------------
" Autosave config for the vimtex config
augroup TexAutoWrite
       autocmd filetype tex :autocmd! TextChanged,TextChangedI <buffer> silent write
       " autocmd filetype markdown :autocmd! TextChanged,TextChangedI <buffer> silent write
augroup END

" -----------------------
" Asynctask config
noremap <leader>r :AsyncTask file-run<cr>
noremap <leader>b :AsyncTask file-build<cr>
" noremap <leader>c :AsyncTask cmake-configure<cr>
" noremap <leader>b :AsyncTask cmake-build-run<cr>
let g:asynctasks_term_pos = 'tab'
let g:asyncrun_open = 10

" -----------------------
"  Colorscheme config: airline, srcery
set noshowmode      " remove -- INSERT --
set termguicolors
let g:srcery_italic = 1
let g:airline#extensions#tabline#enabled= 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'
colorscheme srcery
hi Normal guibg=NONE ctermbg=NONE " remove background

" -----------------------
"  remap keys
" :inoremap ii <Esc> " map ii in insertmode to Escape
tnoremap <Esc> <C-\><C-n> " allow ESC in terminal mode
vmap <Leader>y "+y " map copy to system clipboard
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader>f :Neoformat<CR>
