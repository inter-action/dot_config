

require('textcase').setup {}

local status, telescope = pcall(require, "telescope")
if (not status) then
    return
end

local utils = require('../lua-utils')

telescope.load_extension('textcase')
utils.map_command('n', ';cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
utils.map_command('v', ';cc', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
