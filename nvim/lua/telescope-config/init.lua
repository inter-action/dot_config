local status, telescope = pcall(require, "telescope")
if (not status) then
    return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local utils = require("../lua-utils")

local function telescope_buffer_dir()
    return vim.fn.expand("%:p:h")
end

local map = utils.map_func

telescope.setup {
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close
            },
            ["i"] = {
                -- ["<C-u>"] = function() vim.cmd('normal dd') end,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        }
    }
}

-- keymaps
-- map iterm with send vim chars, map `<Cmd-p>` to `\<M-p>`
function find_files()
    builtin.find_files(
        {
            -- no_ignore = false,
            -- hidden = true
        }
    )
end
map("n", "<M-p>", find_files)
-- map("n", ";f", find_files)

function buffers()
    builtin.buffers()
end

map("n", "<M-b>", buffers)
-- map("n", ";b", buffers)

map("n", ";r",
    function()
        builtin.live_grep()
    end
)
map("n", ";s",
    function()
        builtin.lsp_document_symbols()
    end
)
map("n", ";c",
    function()
        builtin.commands()
    end
)
map("n", ";ch",
    function()
        builtin.command_history()
    end
)
map("n", ";m",
    function()
        builtin.marks()
    end
)
map("n", ";a",
    function()
        builtin.builtin()
    end
)
map('n', ';;', 
    function()
        builtin.resume()
    end
)

map('n', ';;', 
    function()
        builtin.resume()
    end
)

telescope.load_extension('textcase')
utils.map_command('n', ';cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
utils.map_command('v', ';cc', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })