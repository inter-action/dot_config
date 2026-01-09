local config = function()
    require('textcase').setup {}

    local status, telescope = pcall(require, "telescope")
    if (not status) then
        return
    end

    local ok, utils = pcall(require, 'lua-utils')
    if not ok then
        vim.notify('lua-utils not available for text-case mappings', vim.log.levels.WARN)
        return
    end

    telescope.load_extension('textcase')
    utils.map_command('n', ';cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })
    utils.map_command('v', ';cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = 'Telescope' })

end

-- change case
return {
    "johmsalas/text-case.nvim",
    config = config
}