local utils = require("../lua-utils")
local merge2 = utils.merge2


local opts = { silent=false, noremap = true }
local slicent_opts = { silent=true }

-- input mode, editing. config inside init.vm
-- vim.keymap.set('i', '<C-l>', utils.move_cursor_next, { desc = "move cursor to right" })

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

-- Bookmark mappings
vim.keymap.set('n', '<Leader>m', '<Plug>BookmarkToggle', { desc = 'Toggle Bookmark' })
vim.keymap.set('n', '<Leader>l', '<Plug>BookmarkShowAll', { desc = 'Show All Bookmarks' })

-- Navigation mappings
vim.keymap.set('n', 'H', '^', { desc = 'Move to beginning of line' })
vim.keymap.set('n', 'L', '$', { desc = 'Move to end of line' })
vim.keymap.set('n', '[t', 'gT', { desc = 'Previous Tab' })
vim.keymap.set('n', ']t', 'gt', { desc = 'Next Tab' })
vim.keymap.set('n', '[b', ':bp<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', ']b', ':bn<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[c', ':cp<CR>', { desc = 'Previous Quickfix' })
vim.keymap.set('n', ']c', ':cn<CR>', { desc = 'Next Quickfix' })

-- Insert mode mappings
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move Left in Insert Mode' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move Right in Insert Mode' })
vim.keymap.set('i', '<C-e>', '<End>', { desc = 'Move to End in Insert Mode' })
vim.keymap.set('i', '<C-a>', '<Home>', { desc = 'Move to Start in Insert Mode' })

-- Window navigation mappings
vim.keymap.set('n', 's-', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', 's\\', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<C-w>-', '<C-w>s', { desc = 'Split window horizontally (alternative)' })
vim.keymap.set('n', '<C-w>\\', '<C-w>v', { desc = 'Split window vertically (alternative)' })
vim.keymap.set('n', 'sc', '<C-w>c', { desc = 'Close window' })
vim.keymap.set('n', 'ss', '<C-w>w', { desc = 'Switch window' })
vim.keymap.set('n', 'sh', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', 'sl', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', 'sj', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', 'sk', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-w><Left>', '<C-w>5<', { desc = 'Resize window left' })
vim.keymap.set('n', '<C-w><Right>', '<C-w>5>', { desc = 'Resize window right' })
vim.keymap.set('n', '<C-w><Up>', '<C-w>5+', { desc = 'Resize window up' })
vim.keymap.set('n', '<C-w><Down>', '<C-w>5-', { desc = 'Resize window down' })

-- Clipboard yank mapping
vim.keymap.set('v', '<leader>y', '"+y', { silent = true, desc = 'Yank to system clipboard' })

-- Terminal mode mapping
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Prevent paste in visual mode from replacing unnamed buffer
vim.keymap.set('x', 'p', 'P', { desc = 'Prevent paste from replacing unnamed buffer' })

-- Search-related mappings
vim.keymap.set('n', 'n', 'nzz', { silent = true, desc = 'Next search result centered' })
vim.keymap.set('n', 'N', 'Nzz', { silent = true, desc = 'Previous search result centered' })
vim.keymap.set('n', '*', '*zz', { silent = true, desc = 'Search word under cursor forward centered' })
vim.keymap.set('n', '#', '#zz', { silent = true, desc = 'Search word under cursor backward centered' })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true, desc = 'Search partial word forward centered' })

-- Disable highlighting search result on Enter key
vim.keymap.set('n', '<CR>', ':nohlsearch<CR><CR>', { silent = true, desc = 'Disable search highlight' })

-- Very magic search mappings
vim.keymap.set('n', '?', '?\\v', { desc = 'Very magic backward search' })
vim.keymap.set('n', '/', '/\\v', { desc = 'Very magic forward search' })
vim.keymap.set('n', ':g/', ':g/\\v', { desc = 'Very magic global search' })
vim.keymap.set('n', ':g//', ':g//', { desc = 'Repeat last global search' })

-- Line navigation mappings
vim.keymap.set('n', 'j', 'gj', { desc = 'Move down visually' })
vim.keymap.set('n', 'k', 'gk', { desc = 'Move up visually' })

