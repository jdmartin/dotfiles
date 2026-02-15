" === Autocmds for Formatting (Vimscript) ===
autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = false })
autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false })
autocmd BufWritePre *.css,*.scss,*.sass,*.js,*.ts lua vim.lsp.buf.format({ async = false })

lua << EOF
-- 1. Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "gopls", "ts_ls", "bashls", "html", "rust_analyzer", "intelephense" },
})

-- 2. Shared on_attach (Keymaps)
local my_on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

-- 3. The Modern Setup Function
local function setup_server(name, custom_config)
  local config = {
    on_attach = my_on_attach,
    capabilities = _G.lsp_capabilities or nil,
  }

  if custom_config then
    config = vim.tbl_deep_extend("force", config, custom_config)
  end

  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- 4. Standard Servers
for _, name in ipairs({ "ts_ls", "bashls", "html", "rust_analyzer" }) do
  setup_server(name)
end

-- 5. Intelephense (Fixed Stubs & WP Support)
setup_server("intelephense", {
  init_options = {
    globalStoragePath = os.getenv("HOME") .. "/.cache/intelephense",
    storagePath = "/tmp/intelephense",
  },
  settings = {
    intelephense = {
      stubs = { 
        "apache", "bcmath", "bz2", "calendar", "Core", "curl", "date", "dom", 
        "filter", "gd", "hash", "iconv", "imap", "json", "libxml", "mbstring", 
        "mysqli", "openssl", "pcre", "PDO", "pdo_mysql", "Phar", "readline", 
        "SimpleXML", "soap", "sockets", "sqlite3", "standard", "tokenizer", 
        "xml", "xmlreader", "xmlwriter", "zip", "zlib", "wordpress" 
      },
      files = { maxSize = 1000000, associations = { "*.php", "*.inc" } },
      environment = { includePaths = { "/Users/Jon/.config/nvim/stubs" } },
      diagnostics = { enable = true },
    },
  },
})

-- 6. Go & Python
setup_server("gopls", {
  settings = { gopls = { usePlaceholders = true, completeUnimported = true } }
})
setup_server("pyright", {
  settings = { 
    python = { 
      analysis = { typeCheckingMode = "basic" } 
    } 
  }
})

-- 7. Null-ls (Restored Formatting)
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettier,
  },
  on_attach = my_on_attach,
})

-- 8. Configure how the diagnostic window looks
vim.diagnostic.config({
  virtual_text = false, -- Turn off the 'ghost' text if it's too noisy
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- 9. Trigger the window automatically on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- Only open if there's actually a diagnostic on the current line
    -- and we aren't already in a floating window
    if vim.diagnostic.get_next() then
        vim.diagnostic.open_float(nil, { focusable = false })
    end
  end,
})

-- 10. Shorten the wait time (default is 4000ms, which is way too slow)
-- 500ms is a comfortable 'hover' delay.
vim.o.updatetime = 500
EOF
