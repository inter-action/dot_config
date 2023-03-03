local status, telescope = pcall(require, "telescope")
if (not status) then
    return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
    return vim.fn.expand("%:p:h")
end

telescope.setup {
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close
            },
            ["i"] = {
                ["<C-u>"] = function() vim.cmd('normal dd') end,
            },
        }
    }
}

-- keymaps
vim.keymap.set("n", ";f",
    function()
        builtin.find_files(
            {
                no_ignore = false,
                hidden = true
            }
        )
    end
)
vim.keymap.set( "n", ";b",
    function()
        builtin.buffers()
    end
)
vim.keymap.set( "n", ";r",
    function()
        builtin.live_grep()
    end
)
vim.keymap.set( "n", ";c",
    function()
        builtin.commands()
    end
)
vim.keymap.set( "n", ";ch",
    function()
        builtin.command_history()
    end
)
vim.keymap.set( "n", ";ht",
    function()
        builtin.help_tags()
    end
)
vim.keymap.set( "n", ";a",
    function()
        builtin.builtin()
    end
)
vim.keymap.set('n', ';;', 
    function()
        builtin.resume()
    end
)
