-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(
        opts.name,
        {
            texthl = opts.name,
            text = opts.text,
            numhl = ""
        }
    )
end

sign({name = "DiagnosticSignError", text = "✕"})
sign({name = "DiagnosticSignWarn", text = "W"})
sign({name = "DiagnosticSignHint", text = "H"})
sign({name = "DiagnosticSignInfo", text = "I"})

vim.diagnostic.config(
    {
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = false,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = ""
        }
    }
)

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
