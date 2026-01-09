-- alias
-- Auto-commands: use descriptive callbacks and avoid global side effects
local opt = vim.opt

-- adjust quickfix window height automatically, limit its range in [10, 30]
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        local minheight, maxheight = 10, 30
        local lines = math.max(math.min(vim.fn.line('$'), maxheight), minheight)
        vim.api.nvim_win_set_height(0, lines)
    end,
    desc = 'Adjust quickfix height',
})

-- Jump to last edit position on opening file (skip inside .git tree)
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local path = vim.fn.expand('%:p')
        local last_pos = vim.fn.line('\'"')
        if path:match('/%.git/') == nil and last_pos > 1 and last_pos <= vim.fn.line('$') then
            pcall(vim.cmd, 'normal! g\'"')
        end
    end,
    desc = 'Jump to last edit position on opening file',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
    end,
    desc = 'Highlight on yank',
})

-- Auto save on focus lost
vim.api.nvim_create_autocmd('FocusLost', {
    command = 'silent! wa',
    desc = 'Auto save on focus lost',
})

-- Set winbar to show the current buffer's file path
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    group = vim.api.nvim_create_augroup('WinbarFilename', { clear = true }),
    callback = function()
        vim.wo.winbar = vim.fn.expand('%:p'):gsub(vim.loop.cwd() .. '/', '')
    end,
    desc = 'Show relative file path in winbar',
})

return true
