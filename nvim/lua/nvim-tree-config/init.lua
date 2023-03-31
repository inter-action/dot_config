--
-- empty setup using defaults

require("nvim-tree").setup({
    view = {
        width = 45,
    },
    renderer = {
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true,
            }
        }
    }
})
