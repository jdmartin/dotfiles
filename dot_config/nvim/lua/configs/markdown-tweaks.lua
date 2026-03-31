-- === markdown-tweaks.lua ===

local status, render_md = pcall(require, "render-markdown")
if not status then
    return
end

render_md.setup({
    -- This fixes the "config is a boolean" error by ensuring 
    -- we pass a valid table to the internal resolver.
    enabled = true,
    
    -- Sync with your existing Treesitter choices
    -- (Remember we disabled the broken markdown queries earlier)
    render_modes = { 'n', 'c' }, -- Normal and Command modes
    
    anti_conceal = {
        enabled = true,
    },
    
    -- Since we're using Dracula, let's make sure the 
    -- heading colors don't clash
    heading = {
        sign = false,
        icons = { '◉ ', '○ ', '✸ ', '✿ ' },
    },
})

-- Optional: Keymap to toggle the rendering if it gets in the way
vim.keymap.set('n', '<leader>mt', '<cmd>RenderMarkdown toggle<cr>', { silent = true })
