-- alias
local opt = vim.opt

-- adjust quickfix window height automatically, limit its range in [10, 30]
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        local minheight = 10
        local maxheight = 30
        local lines = math.max(math.min(vim.fn.line("$"), maxheight), minheight)
        vim.api.nvim_win_set_height(0, lines)
    end
})

-- need to disable telescope's border first
-- vim.o.winborder = 'rounded'

-- Moved from init.vim
-- Auto commands
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        if vim.fn.expand('%:p'):match('/%.git/') == nil and vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line('$') then
            vim.cmd("normal! g'\"")
        end
    end,
    desc = 'Jump to last edit position on opening file'
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = 'Highlight on yank'
})

vim.api.nvim_create_autocmd('FocusLost', {
    command = 'silent! wa',
    desc = 'Auto save on focus lost'
})

