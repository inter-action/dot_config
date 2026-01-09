-- Diagnostics configuration for Neovim
-- Use `vim.diagnostic` API and create autocmds via `nvim_create_autocmd`

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for sev, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. sev
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}

-- Show diagnostics float on CursorHold (non-focusable)
-- vim.o.signcolumn = 'yes'
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
    desc = 'Open diagnostics float on CursorHold',
})

return true
