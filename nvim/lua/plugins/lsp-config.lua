-- Diagnostic keymaps
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then desc = 'LSP: ' .. desc end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')

    nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
    nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')


    nmap('<F2>', vim.lsp.buf.rename, 'rename')
    nmap('<space>a', vim.lsp.buf.code_action, 'code action')
    nmap('<space>D', vim.lsp.buf.type_definition, 'Type Definition')

    nmap('<space>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    nmap('<space>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

    -- Lesser used LSP functionality
    nmap('<space>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
    nmap('<space>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
    nmap('<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        'Workspace List Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_) vim.lsp.buf.format() end,
        { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.

local servers = {
    clangd = {},
    gopls = {},
    -- pyright = {},
    cssls = {},
    rust_analyzer = {},
    -- tsserver = {},
    html = { filetypes = { 'html', 'twig', 'hbs' } },
    lua_ls = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false }
        }
    }
}


return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            -- when use together with hrsh7th/nvim-cmp
            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            -- local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local lspconfig = require('lspconfig')
            local blinkcmp = require('blink.cmp')

            -- Ensure the servers above are installed
            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }

            mason_lspconfig.setup_handlers {
                function(server_name)
                    lspconfig[server_name].setup {
                        capabilities = blinkcmp.get_lsp_capabilities(lspconfig[server_name].capabilities),
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes
                    }
                end
            }
        end,
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig"
        }
    },
    {
        "neovim/nvim-lspconfig",
        -- dependencies = { 'saghen/blink.cmp' },
    }
}