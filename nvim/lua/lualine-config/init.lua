local utils = require("../lua-utils")

require('lualine').setup({
    sections = {
        lualine_c = { utils.get_buffer_relative_filename },
    }
})

