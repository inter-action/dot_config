return {
    'nvim-lualine/lualine.nvim',
    config = function ()
        
    local utils = require("../lua-utils")
    

    function hydra_status()
        local ok, hydra = pcall(require, 'hydra.statusline')
        if not ok then
            return ""
        end
        
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
                },
                {
                    'mode',
                    fmt = utils.get_buffer_relative_filename,
                },
            },
        }
    })
    end,
}