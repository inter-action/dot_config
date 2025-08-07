return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },

    enable = true,
    -- opts = {},
    config = function()
        local builtin = require('fzf-lua')
        local utils = require('../lua-utils')
        local map = utils.map_func

        map("n", ";p", function() builtin.files() end)
        map("n", ";o", function() builtin.oldfiles() end)

        -- map("n", ";f", function()
        --     local search_file = vim.fn.expand('<cword>')
        --     local option = vim.tbl_extend('force', theme, { search_file = search_file })
        --     builtin.find_files(option)
        -- end)


        map("n", ";b", function() builtin.buffers() end)

        -- use ;<Esc> to repeat find instead!
        map("n", ";r", function() builtin.live_grep() end)
        map("n", ";s", function() builtin.lsp_document_symbols() end)
        map("n", ";c", function() builtin.commands() end)
        map("n", ";ch", function() builtin.command_history() end)
        map("n", ";a", function() builtin.builtin() end)
        map('n', ';;', function() builtin.resume() end)
    end
}