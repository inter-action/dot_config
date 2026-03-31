return {
    -- Editor
    ---- search
    'jremmen/vim-ripgrep',

    -- add surrouding senmatics,
    -- yi(, yank in ()
    -- yi", yank in ""
    'tpope/vim-surround',

    -- auto close open brackets/parenthesis
    {
        'nvim-mini/mini.pairs',
        version = false,
        config = function()
            require('mini.pairs').setup()
        end,
    },

    -- UI
    ---- notify
    {
        'rcarriga/nvim-notify',
        event = 'VimEnter',
        config = function()
            vim.notify = require('notify')
        end,
    },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    ---- which key
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show { global = false }
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },
    ---- theme
    {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {
                groups = {
                    nightfox = {
                        DiagnosticUnderlineError = { fg = '#dc362e' },
                    },
                    dayfox = {
                        DiagnosticUnderlineError = { fg = '#dc362e', bg = '#fcebeb' },
                    },
                },
            }
            local theme = os.getenv('NVIM_THEME') or 'nightfox' -- default to nightfox
            vim.cmd('colorscheme ' .. theme)
        end,
    },

    -- markdown
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            link = {
                -- Turn on / off inline link icon rendering.
                enabled = true,
            },
        },
        enabled = true,
    },
}
