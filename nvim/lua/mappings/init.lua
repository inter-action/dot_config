local utils = require("../lua-utils")

local opts = { silent=false }

-- nvim tree
utils.map_command("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
utils.map_command("n", "<leader>nf", ":NvimTreeFindFile<CR>", opts)
utils.map_command("n", "<leader>nn", ":NvimTreeToggle<CR>", opts)


--- quit & write
utils.map_func("n", "<space>z", 
    function()
        vim.api.nvim_command("silent wa")
        vim.api.nvim_command("stop")
    end, opts)

utils.map_func("n", ";w", function()
    vim.api.nvim_command("wa")
end, opts)

utils.map_func("n", ";q", 
    function()
        local modifiable = vim.bo.modifiable
        -- local modified = vim.bo.modified
        local is_noname_buffer = vim.fn.expand('%:p') == '' -- same as, vim.api.nvim_buf_get_name(0)

        if not modifiable then
            return vim.api.nvim_command("q")
        end

        if not is_noname_buffer then
            vim.api.nvim_command("x")
            return 
        end

        return vim.ui.select({ 'y', 'n' }, {
            prompt = 'no name buffer, force close? :',
        }, function(choice)
            if choice == 'y' then
                vim.api.nvim_command("q!")
            else
                return
            end
        end)

    end, opts)

utils.map_func("n", "<leader><leader>q", 
    function()
        vim.api.nvim_command("wa")
        vim.api.nvim_command("qa!")
    end, opts)

utils.map_func("n", ";rr", 
    function()
        local cword = vim.fn.expand('<cword>')
        local search = vim.fn.input("Keywords > ", cword)
        vim.api.nvim_feedkeys(":Rg -F '" .. search .. "' -w", "n", false)
    end, opts)

-- fold
-- map iterm with <cmd-[> to zc and map <cmd-]> to zo
utils.map_func("n", "zf", 
    function()
        local foldlevel = vim.fn.input("foldlevel > ")
        vim.api.nvim_command("set foldlevel=" .. foldlevel)
    end, opts)

-- quickfix window
utils.map_func("n", "<F4>", 
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
utils.map_func("n", "<F2>", 
    function()
        vim.api.nvim_command("BufferLinePick")
    end, opts)

utils.map_func("n", "<F3>", 
    function()
        vim.api.nvim_command("BufferLinePickClose")
    end, opts)
