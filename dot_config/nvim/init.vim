" === BASIC SETTINGS ===
set encoding=utf-8
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set confirm                   " Confirm on quit if there are unsaved changes
set clipboard+=unnamed        " Use system clipboard
set selection=exclusive       " Don't grab the gutter when selecting
set noswapfile                " No swapfile
set backspace=indent,eol,start
set wildmenu                  " Wildmenu on
set wildoptions=pum           " Popup menu style
set mouse=a                   " Enable mouse in all modes

" Set viminfo file (optional — Neovim uses shada instead)
"if has('nvim')
"    set shada+=n~/.config/nvim/viminfo
"endif

" === FILETYPE DETECTION ===
filetype plugin on

" === PLUGIN MANAGER BOOTSTRAP (vim-plug) ===
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" === PLUGINS ===
call plug#begin(stdpath('data') . '/plugged')
    Plug 'dracula/vim', { 'as': 'dracula' }

    " For Completions
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
   
    " LSP support
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'nvimtools/none-ls.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'folke/trouble.nvim'

    " Optional (for status info, prettier UI)
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lualine/lualine.nvim'

    " telescope
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope.nvim'

    " nerdtree
    Plug 'preservim/nerdtree'

    " signature
    Plug 'jdmartin/vim-signature'
	
call plug#end()

" === Trouble Setup ===
lua << EOF
require("trouble").setup()

-- Try this updated mapping
vim.keymap.set("n", "<leader>d", function()
  require("trouble").toggle("diagnostics")
end, { desc = "Toggle Trouble Diagnostics" })
EOF

" === MISC CONFIG FILES ===
source ~/.config/nvim/configs/completion.vim
source ~/.config/nvim/configs/floating-term.vim
source ~/.config/nvim/configs/formatting.vim
source ~/.config/nvim/configs/keymaps.vim
source ~/.config/nvim/configs/lsp-related.vim
source ~/.config/nvim/configs/lualine.vim
source ~/.config/nvim/configs/nerdtree.vim
source ~/.config/nvim/configs/search-related.vim
source ~/.config/nvim/configs/telescope.vim
source ~/.config/nvim/configs/theme-tweaks.vim
