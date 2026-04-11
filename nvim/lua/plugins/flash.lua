-- see treesitter for expand selection
-- use `` to jump back previous cursor position
return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    version = 'v2.*',
    ---@type Flash.Config
    opts = {},
    keys = {
        -- don't set default keybinding for key
        -- https://github.com/folke/flash.nvim/blob/fcea7ff883235d9024dc41e638f164a450c14ca2/lua/flash/plugins/char.lua#L111
        -- repeat char find using f/F
        { ';', mode = { 'n' }, '', desc = 'ignore this key' },
        { ',', mode = { 'n' }, '', desc = 'ignore this key' },

        {
            'S',
            mode = { 'n' },
            function()
                require('flash').jump {
                    search = { wrap = false, multi_window = true },
                }
            end,
            desc = 'Flash',
        },
        {
            '<leader><leader>w',
            mode = { 'n' },
            function()
                require('flash').jump {
                    search = { forward = true, wrap = false, multi_window = false },
                }
            end,
            desc = 'Flash jump forward',
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

        -- open treesitter, outwards from current node
        -- prefer: treesitter plugin, to init selection
        -- {
        --     'S',
        --     mode = { 'n', 'x', 'o' },
        --     function()
        --         require('flash').treesitter()
        --     end,
        --     desc = 'Flash Treesitter',
        -- },
        -- keymap mode: o, object mode
        -- keymap mode: x, visual mode
        -- see: mapmode for help
        --
        -- remote mode
        -- how to use: yr<target char>
        -- example: yrFw
        -- it'll move cursor to target F char, yank the word, then move cursor back
        --
        -- prefer jump then use `` to jump back
        -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },

        -- yR<char>
        {
            'R',
            mode = { 'o', 'x' },
            function()
                require('flash').treesitter_search()
            end,
            desc = 'Treesitter Search',
        },
        -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}
