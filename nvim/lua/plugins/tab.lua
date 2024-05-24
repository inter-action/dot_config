-- tabs
return {
    'akinsho/bufferline.nvim', 

    version = "*",
    opts = {
        options = {
            diagnostics = false,
            indicator = {
                icon = '▎',
            },
            buffer_close_icon = '✘',
        }
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    }
}

