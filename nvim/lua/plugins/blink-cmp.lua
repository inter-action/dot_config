return {
    {
        'L3MON4D3/LuaSnip',
        -- follow latest release.
        version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp"
        config = function()
            local lua_paths = { vim.fn.stdpath('config') .. '/lua/snippets' }
            -- print("lua_paths: " .. vim.inspect(lua_paths))

            -- load snippet from friendly-snippets
            require('luasnip.loaders.from_vscode').lazy_load()

            -- load custom snippets
            require('luasnip.loaders.from_lua').load {
                -- ~/.config/nvim/lua/snippets
                paths = lua_paths,
            }
        end,
        dependencies = { 'rafamadriz/friendly-snippets' },
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        -- use a release tag to download pre-built binaries
        version = 'v1.*',
        dependencies = 'L3MON4D3/LuaSnip',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- see h: blink
            keymap = {
                ['<C-u>'] = {
                    function(cmp)
                        return cmp.scroll_documentation_up(4)
                    end,
                    'fallback',
                },
                ['<C-d>'] = {
                    function(cmp)
                        return cmp.scroll_documentation_down(4)
                    end,
                    'fallback',
                },
                ['<Tab>'] = {
                    'snippet_forward',
                    function(cmp)
                        return cmp.select_and_accept()
                    end,
                    'fallback',
                },
                ['<S-Tab>'] = {
                    'snippet_backward',
                    'fallback',
                },
                ['<CR>'] = {
                    function(cmp)
                        return cmp.select_and_accept()
                    end,
                    'fallback',
                },
                -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                -- disable default keymap, so to perfer our own mappings in insert mode
                ['<C-k>'] = { 'fallback' },
                ['<C-e>'] = {
                    -- function(cmp)
                    --     return cmp.select_and_accept()
                    -- end,
                    'fallback',
                },
            },

            -- appearance = {
            --     -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            --     -- Adjusts spacing to ensure icons are aligned
            --     nerd_font_variant = 'mono',
            -- },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                -- upon accept, adding brackets automatically
                accept = { auto_brackets = { enabled = true } },
            },

            snippets = { preset = 'luasnip' },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = 'prefer_rust_with_warning' },

            signature = { enabled = true },
        },
        -- opts_extend = { 'sources.default' },
    },
}
