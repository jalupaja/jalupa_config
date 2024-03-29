" howto update:
" :PlugUpgrade
" :PlugUpdate

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
set termguicolors

syntax on
filetype plugin on
filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdcommenter'     " commend Keybindings
Plug 'jiangmiao/auto-pairs'         " automatic brackets

" --- color schemes
"Plug 'itchyny/lightline.vim'
" ---

Plug 'honza/vim-snippets'           " autocomplete snippets
Plug 'sirver/ultisnips'             " configure snippets
Plug 'skywind3000/asynctasks.vim'   " auto build, run stuff
Plug 'skywind3000/asyncrun.vim'
Plug 'sbdchd/neoformat'             " auto formatter
Plug 'KabbAmine/vCoolor.vim'        " color picker

" --- language support
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " Syntax completion support
Plug 'lervag/vimtex'                " LaTeX support
"Plug 'shirk/vim-gas'                " assembler support
Plug 'philj56/vim-asm-indent'

" ----------------------
" configure extra coc extensions. rest is in in coc-settings.json
let g:coc_global_extensions = ['coc-pyright', 'coc-cmake', 'coc-java', 'coc-powershell', 'coc-git', 'coc-html', 'coc-css', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-json', 'coc-vimtex' , 'coc-markdownlint']

" ----------------------
"  change <leader> to space
let mapleader=" "

" -----------------------
"  use ranger as filemanager
let g:rnvimr_ex_enable = 1
nmap <leader>m :RnvimrToggle<CR>

" -----------------------
"  Snippet config
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-n>'
let g:UltiSnipsJumpBackwardTrigger='<c-p>'
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.config/jalupa_config/neovim/snippets']
let g:UltiSnipsSnippetsDir = $HOME.'/.config/jalupa_config/neovim/snippets'

" -----------------------
" LaTeX config
" set shellslash " for win32
let g:tex_falvor='latex'
let g:vimtex_indent_enabled = 1
let g:vimtex_complete_recursive_bib = 1
let g:vimtex_complete_close_baces = 1
let g:vimtex_quickfix_mode = 0
let g:vimtex_quickfix_open_on_warning = 1
let g:vimtex_view_method = 'zathura'    " use zathura as build in viewer method
"let g:vimtex_view_general_viewer = 'okular' " use generic interface
"let g:vimtex_view_general_viewer = '--unique file:@pdf/#src:@line@tex'

" -----------------------
" Autosave config for the vimtex config
augroup Autosave
       autocmd filetype tex :autocmd! TextChanged,TextChangedI <buffer> silent write
       " autocmd filetype markdown :autocmd! TextChanged,TextChangedI <buffer> silent write
augroup END

" -----------------------
"  autosave html/css/scss files (doesnt work as tex files above because live-server
"  crashes after one change)
autocmd filetype html :autocmd! TextChanged,TextChangedI <buffer> silent write
autocmd filetype css :autocmd! TextChanged,TextChangedI <buffer> silent write
autocmd filetype scss :autocmd! TextChanged,TextChangedI <buffer> silent write

" -----------------------
" use nasm syntax highlighting for asm files
autocmd BufNew,BufRead *.asm set ft=nasm

" -----------------------
" Asynctask config
noremap <leader>r :AsyncTask file-run<cr>
noremap <leader>b :AsyncTask file-build<cr>
" noremap <leader>c :AsyncTask cmake-configure<cr>
" noremap <leader>b :AsyncTask cmake-build-run<cr>
let g:asynctasks_term_pos = 'tab'
let g:asyncrun_open = 10

" -----------------------
"  Colorscheme config: lightline, srcery
"set noshowmode      " remove -- INSERT --
"let g:srcery_italic = 1
"let g:lightline = {
            "\ 'colorscheme': 'srcery',
               "\ 'active': {
               "\   'right': [ [ 'lineinfo' ],
               "\              [ 'percent' ],
               "\              [ 'fileformat', 'fileencoding' ] ]
               "\ },
               "\ 'component': {
               "\   'charvaluehex': '0x%B'
               "\ },
               "\ }
"colorscheme srcery
"hi Normal guibg=NONE ctermbg=NONE " remove background

" -----------------------
"  remap keys
" :inoremap ii <Esc> " map ii in insertmode to Escape
tnoremap <Esc> <C-\><C-n> " allow ESC in terminal mode
vmap <Leader>y "+y " map copy to system clipboard
inoremap ii <Esc>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader>f :Neoformat<CR>
