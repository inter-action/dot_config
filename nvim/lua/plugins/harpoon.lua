local config = function()
    local ok, utils = pcall(require, 'lua-utils')
    if not ok then
        vim.notify('lua-utils not available for harpoon mappings', vim.log.levels.WARN)
        return
    end
    local merge2 = utils.merge2
    local harpoon_mark = require('harpoon.mark')
    local harpoon_ui = require('harpoon.ui')

    local opts = { silent = false, noremap = true }
    local slicent_opts = { silent = true }

    -- mark
    utils.map_func('n', ';m', function()
        harpoon_mark.add_file()
    end, merge2(slicent_opts, { desc = 'harpoon add file' }))

    -- list
    utils.map_func('n', ';l', function()
        harpoon_ui.toggle_quick_menu()
    end, merge2(slicent_opts, { desc = 'harpoon list' }))
end

return {
    'ThePrimeagen/harpoon',
    enabled = false,
    config = config,
}
