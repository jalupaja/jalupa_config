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
Plug 'ctrlpvim/ctrlp.vim'           " File Search via CTRL-P

" --- color schemes
Plug 'srcery-colors/srcery-vim'
Plug 'itchyny/lightline.vim'
" ---

Plug 'pechorin/any-jump.vim'        " 
"Plug 'scrooloose/nerdtree'         " file explorer
"Plug 'vim/devicons'                " devicons for nerdtree
Plug 'kevinhwang91/rnvimr'          " ranger support
Plug 'honza/vim-snippets'           " autocomplete snippets
Plug 'sirver/ultisnips'             " configure snippets
Plug 'skywind3000/asynctasks.vim'   " auto build, run stuff
Plug 'skywind3000/asyncrun.vim'
Plug 'sbdchd/neoformat'             " auto formatter
Plug 'norcalli/nvim-colorizer.lua'  " show color as background on text
Plug 'KabbAmine/vCoolor.vim'        " color picker
Plug 'nvim-treesitter/nvim-treesitter'

" --- language support
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " Syntax completion support
Plug 'lervag/vimtex'                " LaTeX support
"Plug 'shirk/vim-gas'                " assembler support
Plug 'philj56/vim-asm-indent'

" --- debug stuff
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
call plug#end()

" ----------------------
" configure extra coc extensions. rest is in in coc-settings.json
let g:coc_global_extensions = ['coc-pyright', 'coc-cmake', 'coc-java', 'coc-powershell', 'coc-git', 'coc-html', 'coc-css', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-json', 'coc-vimtex' , 'coc-markdownlint']

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

" ----------------------
" colorizer config
lua <<EOF
require'colorizer'.setup()
EOF

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
"  autosave html/css files (doesnt work as tex files above because live-server
"  crashes after one change)
autocmd filetype html :autocmd! TextChanged,TextChangedI <buffer> silent write
autocmd filetype css :autocmd! TextChanged,TextChangedI <buffer> silent write

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

"" vimspector and dapui are configured by Tresonic
" vimspector ------------------------------------------------------------------
lua << EOF
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch intelligent",
    type = "lldb",
    request = "launch",
    program = function()
    local cwd = vim.fn.getcwd()
    local xprog = vim.fn.execute('!find build/src/* -executable -type f', "silent")
    xprog:match("[^\n]*")
    local finpath = ('\n'..xprog):gsub("\n:!find [^\n]*", ""):sub(4)
    finpath = finpath:gsub("\n", "")
    finpath = cwd..'/'..finpath

    print("result: " ..finpath)
    -- print(vim.fn.execute('!ip a', true))
    --print(cwd .. '/build/src/${fileBasenameNoExtension}')
        if vim.fn.executable(finpath) then
            return finpath
        else
            return cwd .. '${fileBasenameNoExtension}' 
        end
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
      env = function()
    local variables = {}
    for k, v in pairs(vim.fn.environ()) do
      table.insert(variables, string.format("%s=%s", k, v))
    end
    return variables
  end,
  },
  {
    name = "launch executable built by tasks",
    type = "lldb",
    request = "launch",
    --program = function()
    --  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --end,
    program = "${fileBasenameNoExtension}.out",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
  {
    name = "Launch Cmake-built",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    --program = "${fileWorkspaceFolder}/build/src/sortviz",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}
dap.configurations.c = dap.configurations.cpp
EOF

" dapui ---------------------------------------------------------------------
lua << EOF
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.5, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      --{ id = "stacks", size = 0.25 },
      --{ id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

require("dapui").setup()
EOF

" keybinds for nvim-dap and nvim-dap-ui -------------------------------------
noremap <leader>do :lua require("dapui").open()<cr>
noremap <leader>dt :lua require("dapui").toggle()<cr>
noremap <leader>dc :lua require("dap").continue()<cr>
noremap <leader>db :lua require("dap").toggle_breakpoint()<cr>
noremap <leader>ds :lua require("dap").step_over()<cr>

" -----------------------
"  Colorscheme config: lightline, srcery
set noshowmode      " remove -- INSERT --
let g:srcery_italic = 1
let g:lightline = {
            \ 'colorscheme': 'srcery',
               \ 'active': {
               \   'right': [ [ 'lineinfo' ],
               \              [ 'percent' ],
               \              [ 'fileformat', 'fileencoding' ] ]
               \ },
               \ 'component': {
               \   'charvaluehex': '0x%B'
               \ },
               \ }
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
