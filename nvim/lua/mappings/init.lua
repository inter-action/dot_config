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
        vim.api.nvim_command("silent wa")
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
        local cword = vim.fn.expand('<cword>')
        local search = vim.fn.input("Keywords > ", cword)
        vim.api.nvim_feedkeys(":Rg -F '" .. search .. "' -w", "n", false)
    end, opts)

-- fold
-- map iterm with <cmd-[> to zc and map <cmd-]> to zo
vim.keymap.set("n", "zf", 
    function()
        local foldlevel = vim.fn.input("foldlevel > ")
        vim.api.nvim_command("set foldlevel=" .. foldlevel)
    end, opts)

-- quickfix window
vim.keymap.set("n", "<F4>", 
    function()
        local wininfos = vim.fn.getwininfo()
        local hasQuickFix = false

        for i = 1, #wininfos do 
            local v = wininfos[i]

            if v.quickfix == 1 then
                hasQuickFix = true
                break
            end
        end

        if hasQuickFix then
            vim.api.nvim_command("cclose")
        else
            vim.api.nvim_command("copen 20")
        end
    end, opts)

-- buffer line
vim.keymap.set("n", "<F2>", 
    function()
        vim.api.nvim_command("BufferLinePick")
    end, opts)

vim.keymap.set("n", "<F3>", 
    function()
        vim.api.nvim_command("BufferLinePickClose")
    end, opts)
