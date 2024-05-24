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
    
    ---- motion
    'easymotion/vim-easymotion',
    'tpope/vim-surround',

    -- UI
    ---- notify
    {
        'rcarriga/nvim-notify',
        -- lazy loading not gonna work for this plugin
        lazy = false,
        -- config = true,
        config = function()
            vim.notify = require("notify")
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    ---- which key
    {
        "folke/which-key.nvim",
        opts = {
            plugins = {
                registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                spelling = {
                  enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                  suggestions = 20, -- how many suggestions should be shown in the list?
                },
            },
        },
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
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

    -- Others
    'vimwiki/vimwiki',
}