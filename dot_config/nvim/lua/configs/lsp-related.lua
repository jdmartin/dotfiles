-- === LSP CONFIGURATION ===

-- 0. TREESITTER CONFIG (Consolidated)
local ts_install_status, ts_install = pcall(require, "nvim-treesitter.install")
if ts_install_status then
    -- Fix the '--no-bindings' warning by bypassing the CLI
    ts_install.prefer_git = true
end

local ts_status, ts_config = pcall(require, "nvim-treesitter.configs")
if ts_status then
    ts_config.setup({
        ensure_installed = { 
            "php", "python", "go", "perl", "javascript", "rust", "lua", "vim", "vimdoc", "html", "latex", "yaml" 
        },
        -- highlight = {
            -- enable = true,
            -- The "Anti-Crash" rule:
            -- disable = { "markdown", "markdown_inline" },
        -- },
    })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype

    -- Ignore specific 'junk' filetypes immediately
    if ft == "trouble" or ft == "NvimTree" or ft == "help" then
      return
    end

    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- Check if we have a parser installed
    local has_parser = pcall(vim.treesitter.get_parser, bufnr, lang)

    if has_parser then
      -- The 'pcall' here is the final safety net
      pcall(vim.treesitter.start, bufnr, lang)
    end
  end,
})

-- 1. LSP HOVER SHIELD (The most important part)
-- This globally forces the hover window to be stable and plain.
vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  local default_config = {
    border = "rounded",
    stylize_markdown = false,
  }
  return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_deep_extend("force", default_config, config or {}))
end

-- 1. Setup Mason (Portable Package Manager)
local mason_status, mason = pcall(require, "mason")
local m_lsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if mason_status and m_lsp_status then
  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = { 
      "pyright", "gopls", "ts_ls", "bashls", "html", 
      "rust_analyzer", "intelephense", "lemminx" 
    },
  })
end

-- 2. Shared on_attach (Keymaps)
local my_on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- "gd" -> Go to definition (Jumps to the file/line)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

  -- "K" -> See definition/hover (Opens the floating window)
  -- We add a protective check to ensure the float is styled consistently
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover({ border = "rounded" })
  end, opts)
  
  -- Optional: "gr" -> See references
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

-- 3. The Setup Helper
-- Uses the global capabilities we defined in completion.lua
local function setup_server(name, custom_config)
  local config = {
    on_attach = my_on_attach,
    capabilities = _G.lsp_capabilities or nil,
  }

  if custom_config then
    config = vim.tbl_deep_extend("force", config, custom_config)
  end

  -- Neovim 0.12 native LSP management
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- 4. Standard Servers
for _, name in ipairs({ "ts_ls", "bashls", "html", "rust_analyzer" }) do
  setup_server(name)
end

-- 5. Intelephense (PHP / WordPress)
setup_server("intelephense", {
  init_options = {
    globalStoragePath = vim.fn.expand("$HOME/.cache/intelephense"),
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
      environment = { includePaths = { "/Users/Jon/.local/stubs" } },
    },
  },
})

-- 6. Go and Python
setup_server("gopls", {
  settings = { gopls = { usePlaceholders = true, completeUnimported = true } }
})

setup_server("pyright", {
  settings = { python = { analysis = { typeCheckingMode = "basic" } } }
})

-- 7. Lemminx (XML)
setup_server("lemminx", {
  settings = {
    xml = { server = { workDir = vim.fn.expand("$HOME/.cache/lemminx") } }
  },
  cmd_env = { LEMMINX_DIR = vim.fn.expand("$HOME/.cache/lemminx") }
})

-- 8. Null-ls (Formatting / Linting)
local n_status, null_ls = pcall(require, "null-ls")
if n_status then
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.prettier,
    },
    on_attach = my_on_attach,
  })
end

-- 9. UI & Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Auto-show diagnostics on hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    if vim.diagnostic.get_next() then
      vim.diagnostic.open_float(nil, { focusable = false })
    end
  end,
})

-- 10. Auto-Formatting on Save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.py", "*.css", "*.scss", "*.js", "*.ts" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Shorten wait time
vim.opt.updatetime = 500
