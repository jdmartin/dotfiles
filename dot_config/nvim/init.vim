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
" === NATIVE PLUGIN MANAGEMENT (Neovim 0.12+) ===
lua << EOF
-- 1. Automate hooks (like Treesitter update)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end
})

-- 2. Define and Load Plugins
vim.pack.add({
    'https://github.com/dracula/vim',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/hrsh7th/cmp-cmdline',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',
    'https://github.com/nvimtools/none-ls.nvim',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
    'https://github.com/folke/trouble.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/preservim/nerdtree',
    'https://github.com/chentoast/marks.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})
EOF

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
luafile ~/.config/nvim/configs/marks.lua

" Source ~/.config/nvim/vimrc.local if it exists (to allow machine-specific tweaks)
let s:local = stdpath('config') . '/vimrc.local'
if filereadable(s:local)
    execute 'source' fnameescape(s:local)
endif
