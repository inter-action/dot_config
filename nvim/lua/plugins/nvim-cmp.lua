local function config()
    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`

    local lspkind = require('lspkind')
    local cmp = require 'cmp'

    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup({
        -- Enable LSP snippets
        snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
        mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            -- <C-f> original mapping
            ['<C-u>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<C-e>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true
            },
            -- vim.api.nvim_paste
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'})
        },
        -- Installed sources:
        sources = {
            {name = 'path'}, -- file paths
            {name = 'nvim_lsp'}, -- from language server
            {name = 'nvim_lsp_signature_help'}, -- display function signatures with current parameter emphasized
            {name = 'nvim_lua', keyword_length = 2}, -- complete neovim's Lua runtime API such vim.lsp.*
            {name = 'buffer', keyword_length = 2}, -- source current buffer
            {name = 'calc'}, -- source for math calculation
            {name = 'luasnip'}
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        formatting = {
            fields = {'menu', 'abbr', 'kind'},
            format = lspkind.cmp_format({
                mode = 'text', -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    return vim_item
                end
            })
        }
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {{name = 'buffer'}}
    })

    --  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
    })

    -- Set completeopt to have a better completion experience
    -- :help completeopt
    -- menuone: popup even when there's only one match
    -- noinsert: Do not insert text until a selection is made
    -- noselect: Do not select, force to select one from the menu
    -- shortness: avoid showing extra messages when using completion
    -- updatetime: set updatetime for CursorHold
    vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
    vim.opt.shortmess = vim.opt.shortmess + {c = true}
    vim.api.nvim_set_option('updatetime', 300)
end

return {
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        -- event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        enabled = false,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", 
            "hrsh7th/cmp-buffer", 
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help', 
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline', 
            'onsails/lspkind.nvim',
            "L3MON4D3/LuaSnip",
            {
                -- this is tight to hrsh5th/nvim-cmp
                "saadparwaiz-1/cmp_luasnip",
                enabled = false,
                dependencies = {
                    "L1MON4D3/LuaSnip",
                    -- follow latest release.
                    version = "v0.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                    enabled = false,
                    -- install jsregexp (optional!).
                    -- build = "make install_jsregexp"
                    dependencies = { "rafamadriz/friendly-snippets" },
                }
            }
        },
        config = config
    },
}
