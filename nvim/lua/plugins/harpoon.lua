local config = function()
    local ok, utils = pcall(require, 'lua-utils')
    if not ok then
        vim.notify('lua-utils not available for harpoon mappings', vim.log.levels.WARN)
        return
    end
    local extends = utils.extends
    local harpoon_mark = require('harpoon.mark')
    local harpoon_ui = require('harpoon.ui')

    -- 80% width
    local width = math.min(120, math.floor(vim.api.nvim_win_get_width(0) * 0.8))
    local height = math.min(40, math.floor(vim.api.nvim_win_get_width(0) * 0.5))
    require('harpoon').setup {
        menu = {
            -- width = vim.api.nvim_win_get_width(0) - 4,
            width = width,
            height = height,
        },
    }

    -- local opts = { silent = false, noremap = true }
    local slicent_opts = { silent = true }

    -- mark
    vim.keymap.set('n', ';m', function()
        harpoon_mark.add_file()
    end, extends(slicent_opts, { desc = 'harpoon: add file' }))

    -- list
    vim.keymap.set('n', ';l', function()
        harpoon_ui.toggle_quick_menu()
    end, extends(slicent_opts, { desc = 'harpoon: list' }))
end

return {
    'ThePrimeagen/harpoon',
    enabled = true,
    config = config,
    dependencies = { 'nvim-lua/plenary.nvim' },
}
