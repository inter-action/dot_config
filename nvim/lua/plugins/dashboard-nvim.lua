return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            disable_move = true,
            config = {
                week_header = {
                    enable = true,
                },
                packages = {
                    enable = false,
                },
            },
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
