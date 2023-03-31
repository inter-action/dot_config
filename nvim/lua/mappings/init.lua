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
    end, opts)

vim.keymap.set("n", "<leader>q", 
    function()
        local modifiable = vim.api.nvim_buf_get_option(0, 'modifiable')
        if modifiable then
            vim.api.nvim_command("w")
        end
        vim.api.nvim_command("q")
    end, opts)

vim.keymap.set("n", "<leader><leader>q", 
    function()
        vim.api.nvim_command("wa")
        vim.api.nvim_command("qa!")
    end, opts)

vim.keymap.set("n", ";rr", 
    function()
        local search = vim.fn.input("Keywords > ")
        vim.api.nvim_feedkeys(":Rg -F '" .. search .. "' ", "n", false)
    end, opts)


