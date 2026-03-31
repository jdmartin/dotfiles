-- === COMPLETION SETTINGS ===
vim.opt.completeopt = { "menuone" }

-- Safely require cmp to avoid errors if the plugin isn't installed yet
local status, cmp = pcall(require, "cmp")
if not status then return end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
})

-- Define capabilities for LSP (used by lsp-related.lua later)
local cmp_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_lsp_status then
    _G.lsp_capabilities = cmp_nvim_lsp.default_capabilities()
end
