return {
    -- search
    "jremmen/vim-ripgrep",
    
    -- motion
    'easymotion/vim-easymotion',
    'tpope/vim-surround',

    -- todo, add these back
    -- auto pair
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    'alvan/vim-closetag',


    -- theme
    "EdenEast/nightfox.nvim",
    -- todo: remove this
    -- 'kyazdani42/nvim-web-devicons',

    -- notify
    'rcarriga/nvim-notify',
    { "nvim-tree/nvim-web-devicons", lazy = true },

    'vimwiki/vimwiki',

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
}