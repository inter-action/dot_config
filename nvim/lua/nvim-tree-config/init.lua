--
-- empty setup using defaults

require("nvim-tree").setup({
    view = {
        width = 45,
    },
    update_focused_file = {
        enable = true,
    },
    hijack_directories = {
        enable = false,
    }
})
