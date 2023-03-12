-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


local opts = { silent=false, silent=true}

-- nvim tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>nf", "<cmd>NvimTreeFindFile<cr>", opts)
map("n", "<leader>nn", "<cmd>NvimTreeToggle<cr>", opts)



--- quit & write
vim.keymap.set("n", "<space>z", 
    function()
        vim.api.nvim_command("wa")
        vim.api.nvim_command("stop")
    end, 
    opts)


vim.keymap.set("n", "<leader><leader>q", 
    function()
        vim.api.nvim_command("wa")
        vim.api.nvim_command("qa!")
    end, 
    opts)