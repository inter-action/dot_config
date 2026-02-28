local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.del('n', 's', { buffer = bufnr })

    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
end

return {
    'kyazdani42/nvim-tree.lua',
    opts = {
        on_attach = my_on_attach,
        view = {
            width = 45,
        },
        update_focused_file = {
            enable = true,
        },
        hijack_directories = {
            enable = false,
        },
    },
}
