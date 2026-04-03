return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    version = 'v2.*',
    ---@type Flash.Config
    opts = {},
    keys = {
        -- don't set default keybinding for key
        -- https://github.com/folke/flash.nvim/blob/fcea7ff883235d9024dc41e638f164a450c14ca2/lua/flash/plugins/char.lua#L111
        { ';', mode = { 'n' }, '', desc = 'ignore this key' },
        { ',', mode = { 'n' }, '', desc = 'ignore this key' },

        {
            '<leader><leader>w',
            mode = { 'n' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
        {
            '<leader><leader>b',
            mode = { 'n' },
            function()
                require('flash').jump {
                    search = { forward = false, wrap = false, multi_window = false },
                }
            end,
            desc = 'Flash',
        },
        -- open treesitter
        {
            'S',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash Treesitter',
        },

        -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}
