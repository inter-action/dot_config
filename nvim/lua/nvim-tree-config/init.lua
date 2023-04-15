--
-- empty setup using defaults

require("nvim-tree").setup({
    view = {
        width = 45,
    },
    -- todo: passing it via cmd line options?
    update_focused_file = {
        enable = true,
    },
    hijack_directories = {
        enable = false,
    }
})
