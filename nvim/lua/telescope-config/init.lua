local status, telescope = pcall(require, "telescope")
if (not status) then return end
local themes = require('telescope.themes')
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local utils = require("../lua-utils")

local map = utils.map_func

telescope.setup {
    defaults = {
        mappings = {
            n = {["q"] = actions.close},
            ["i"] = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                -- ["<C-u>"] = function() vim.cmd('normal dd') end,
                ["<C-h>"] = "which_key",
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            }
        }
    }
}

local theme = themes.get_dropdown({
    previewer = false,
    layout_config = {
        -- width = function(_, max_columns, _)
        --     return math.min(max_columns, 120)
        -- end,
        width = 0.8,
        height = 0.6
    }
})

-- keymaps
-- map iterm with send vim chars, map `<Cmd-p>` to `\<M-p>`
map("n", "<M-p>", function() builtin.find_files(theme) end)
-- map("n", ";f", find_files)

map("n", "<M-b>", function() builtin.buffers(theme) end)
-- map("n", ";b", buffers)

-- use ;<Esc> to repeat find instead!
map("n", ";r", function() builtin.live_grep() end)
map("n", ";s", function() builtin.lsp_document_symbols() end)
map("n", ";c", function() builtin.commands() end)
map("n", ";ch", function() builtin.command_history() end)
-- map("n", ";m",
--     function()
--         builtin.marks()
--     end
-- )
map("n", ";a", function() builtin.builtin() end)
map('n', ';;', function() builtin.resume() end)
