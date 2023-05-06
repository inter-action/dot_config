local utils = require("../lua-utils")
local hydra = require('hydra.statusline')

function hydra_status()
    if hydra.is_active() then 
        return string.format("[%s]", hydra.get_name())
    end

    return ""
end

require('lualine').setup({
    sections = {
        lualine_c = { 
            {
                'mode',
                fmt = hydra_status, 
                icon = '🐍',
                color={bg='#105934'}
            }, 
            {
                'mode',
                fmt = utils.get_buffer_relative_filename,
            },
        },
    }
})