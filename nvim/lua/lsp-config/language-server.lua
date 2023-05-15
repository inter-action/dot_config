-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- local on_attach = function(client, bufnr)
--   -- format on save
--   if client.server_capabilities.documentFormattingProvider then
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = vim.api.nvim_create_augroup("Format", { clear = true }),
--       buffer = bufnr,
--       callback = function() vim.lsp.buf.formatting_seq_sync() end
--     })
--   end
-- end


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- keep sync with mason

local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            -- todo: try to remove this line
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        end,
        capabilities = capabilities,
    }
})

-- install LSP server use :Mason or :LspInstall <gopls> 
local servers = { 'tsserver', 'cssls', 'clangd', 'gopls' }
for _, lsp in ipairs(servers) do
    if lspconfig[lsp] then
        lspconfig[lsp].setup {
            -- on_attach = on_attach,
            capabilities = capabilities,
        }
    end
end

-- this requires html LSP to be installed, use Mason to install
lspconfig.html.setup {
    filetypes = {"html", "handlebars"},
    capabilities = capabilities
}