return {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    config = function()
        local utils = require('../lua-utils')

        require('lualine').setup {
            sections = {
                lualine_c = {
                    {
                        'mode',
                        fmt = utils.get_buffer_relative_filename,
                    },
                },
            },
        }
    end,
}
