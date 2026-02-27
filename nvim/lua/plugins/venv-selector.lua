return {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    opts = {},
    config = function()
        require('venv-selector').setup()
        vim.keymap.set('n', '<leader>vs', require('venv-selector').select, { desc = 'Select Python Virtual Environment' })
    end,
    lazy = true,
    cmd = 'VenvSelect',
}
