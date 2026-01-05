return {
    -- Editor
    ---- auto pair
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    'alvan/vim-closetag',

    ---- search
    "jremmen/vim-ripgrep",
    
    'tpope/vim-surround',

    -- UI
    ---- notify
    {
        'rcarriga/nvim-notify',
        -- lazy loading not gonna work for this plugin
        version = "v3.14.0",    
        event = 'VimEnter',
        -- config = true,
        config = function()
            vim.notify = require("notify")
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    ---- which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        },
        keys = {
          {
            "<leader>?",
            function()
              require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
          },
        },
    },
    ---- theme
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require('nightfox').setup({
                groups = {
                    nightfox = {
                        DiagnosticUnderlineError = { fg = "#dc362e" },
                    },
                    dayfox = {
                        DiagnosticUnderlineError = { fg = "#dc362e", bg = "#fcebeb" },
                    },
                }
            })
            vim.cmd("colorscheme nightfox")
        end
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
            }
        },
        enabled = true
    }
}