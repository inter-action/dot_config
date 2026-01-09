local config = function()
    local zenmode = require('zen-mode')

    zenmode.setup {
        window = {
            width = 0.85,
        },
    }

    vim.keymap.set('n', '<leader>z', function()
        zenmode.toggle {
            window = {
                width = 0.85,
            },
        }
    end)
end

-- zen mode
return {
    'folke/zen-mode.nvim',
    config = config,
}
