local utils = require("../lua-utils")
local merge2 = utils.merge2


local opts = { silent=false, noremap = true }
local slicent_opts = { silent=true }

-- input mode, editing
vim.keymap.set('i', '<C-l>', utils.move_cursor_next, { desc = "move cursor to right" })

-- nvim tree
utils.map_command("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
utils.map_command("n", "<leader>nf", ":NvimTreeFindFile<CR>", opts)


--- quit & write
utils.map_func("n", "<space>z",
    function()
        local ok, _ = pcall(vim.api.nvim_command, "wa")
        vim.api.nvim_command("stop")
    end,
    merge2(slicent_opts, {desc = "hide neovim"}) -- use fg to move neovim to foregroud
)

utils.map_func("n", ";w",
    function()
        vim.api.nvim_command("wa")
    end,
    merge2(opts, {desc = "write all"})
)

utils.map_func("n", ";q",
    function()
        local modifiable = vim.bo.modifiable
        -- local modified = vim.bo.modified
        local is_noname_buffer = vim.fn.expand('%:p') == '' -- same as, vim.api.nvim_buf_get_name(0)

        if not modifiable then
            return vim.api.nvim_command("q")
        end

        if not is_noname_buffer then
            vim.api.nvim_command("bd")
            return
        end

        return vim.ui.select({ '1', '2' }, {
            prompt = 'no name buffer, force close? :',
        }, function(choice)
            if choice == '1' then
                vim.api.nvim_command("bd!")
            else
                return
            end
        end)

    end,
    merge2(opts, {desc = "close file"})
)

utils.map_func("n", "<leader><leader>q",
    function()
        vim.api.nvim_command("wa")
        vim.api.nvim_command("qa!")
    end,
    merge2(opts, {desc = "quit neovim"})
)

utils.map_func("n", ";rr",
    function()
        local cword = vim.fn.expand('<cword>')
        local search = vim.fn.input("Keywords > ", cword)
        vim.api.nvim_feedkeys(":Rg -F '" .. search .. "' -w", "n", false)
    end,
    merge2(opts, {desc = "ripgrep"})
)

-- quickfix window
-- previously was mapped to <F4>

local function toggle_quickfix()
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
end

-- todo: remove this?
utils.map_func("n", "<F4>",
    toggle_quickfix,
    merge2(opts, {desc = "toggle quickfix"})
)

utils.map_func("n", "<C-j>",
    toggle_quickfix,
    merge2(opts, {desc = "toggle quickfix"})
)


-- buffer line
utils.map_func("n", "<leader>tc",
    function()
        vim.api.nvim_command("BufferLinePickClose")
    end,
    merge2(opts, {desc = "BufferLinePickClose"})
)
utils.map_func("n", "<leader>ts",
    function()
        vim.api.nvim_command("BufferLinePick")
    end,
    merge2(opts, {desc = "BufferLinePick"})
)

-- folding
---- map iterm with <cmd-[> to zc and map <cmd-]> to zo
utils.map_func("n", "zf",
    function()
        local foldlevel = vim.fn.input("foldlevel > ")
        vim.api.nvim_command("set foldlevel=" .. foldlevel)
        vim.api.nvim_command("normal zx")
    end,
    merge2(opts, {desc = "set foldlevel"})
)

utils.map_command("n", "z=", "zr", merge2(opts, {desc = "one more fold"}))
utils.map_command("n", "z-", "zm", merge2(opts, {desc = "one less fold"}))