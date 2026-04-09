-- Key mappings: prefer `vim.keymap.set` and descriptive `desc` fields
local utils = require('lua-utils')
local extends = utils.extends

-- Default options for mappings. Use `silent = true` by default for cleaner UX.
local opts = { silent = true, noremap = true }
local slicent_opts = { silent = true }

-- input mode, editing. config inside init.vm
-- vim.keymap.set('i', '<C-l>', utils.move_cursor_next, { desc = "move cursor to right" })
local kset = vim.keymap.set
local M = {}

-- starts: functions
function M.unified_close()
    -- close window/buffer
    local buf = vim.api.nvim_get_current_buf()
    local win_count = vim.fn.winnr('$')

    -- Case 1: Multiple windows → close window
    if win_count > 1 then
        vim.cmd.close()
        return
    end

    -- Case 2: Single window → smart buffer handling
    local buftype = vim.bo[buf].buftype
    local modified = vim.bo[buf].modified
    local modifiable = vim.bo[buf].modifiable

    -- Special / non-modifiable buffers
    if buftype ~= '' or not modifiable then
        vim.cmd.quit()
        return
    end

    -- Unmodified buffer → safe delete
    if not modified then
        vim.api.nvim_buf_delete(buf, { force = false })
        return
    end

    -- Modified buffer → confirm
    local name = vim.api.nvim_buf_get_name(buf)
    local display = name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'

    vim.ui.select({ 'Close without saving', 'Cancel' }, {
        prompt = 'Unsaved changes in ' .. display .. ', continue?',
    }, function(choice)
        if choice == 'Close without saving' then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end)
end

function M.toggle_quickfix()
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
        vim.api.nvim_command('cclose')
    else
        vim.api.nvim_command('copen 20')
    end
end

function M.reload_current_file()
    local file = vim.fn.expand('%:p')

    -- only match lua file under nvim folder
    if file:match(vim.fn.stdpath('config') .. '/.-%.lua$') then
        vim.cmd('source %') -- reload current file
        vim.notify('✅ Lua file reloaded\n-' .. vim.fn.fnamemodify(file, ':t'), vim.log.levels.INFO)
    else
        vim.notify('❌ only nvim lua file can be reload.', vim.log.levels.ERROR)
    end
end

function M.navigate_or_tmux(direction)
    -- navigate window or tmux pane
    local winid = vim.api.nvim_get_current_win()
    local prev_winid = winid

    -- try switch neovim window first
    if direction == 'h' then
        vim.cmd.wincmd('h')
    elseif direction == 'j' then
        vim.cmd.wincmd('j')
    elseif direction == 'k' then
        vim.cmd.wincmd('k')
    elseif direction == 'l' then
        vim.cmd.wincmd('l')
    end

    -- on neovim edge window, do tmux select-pane
    if vim.api.nvim_get_current_win() == prev_winid then
        local tmux_dir = ({ h = 'L', j = 'D', k = 'U', l = 'R' })[direction]
        vim.fn.system('tmux select-pane -' .. tmux_dir)
    end
end

function M.open_url_under_cursor()
    -- link hint and mouse click link
    local url = vim.fn.expand('<cfile>')
    if url:match('^https?://') then
        -- using open on macOS
        vim.fn.jobstart({ 'open', url }, { detach = true })
    end
end

-- ends: functions

-- tmux terminal
-- use <C-d> to close it
vim.keymap.set('n', ';t', function()
    -- current root dir
    local root_dir = vim.fn.getcwd()
    --local cmd = string.format([[tmux display-popup -c %s]], vim.fn.shellescape(root_dir))
    local cmd = [[tmux display-popup -w 50% -h 50% -E -T 'tmux(<C-d> to close)' -d]]
        .. ' '
        .. vim.fn.shellescape(root_dir)
    vim.fn.system(cmd)
end, { silent = true })

--- quit & write
kset(
    'n',
    '<space>z',
    function()
        local ok, _ = pcall(vim.api.nvim_command, 'wa')
        vim.api.nvim_command('stop')
    end,
    extends(slicent_opts, { desc = 'hide neovim' }) -- use fg to move neovim to foregroud
)

kset('n', ';w', function()
    vim.api.nvim_command('wa')
end, extends(opts, { desc = 'write all' }))

--- Close buffer/window reliably
kset('n', ';q', M.unified_close, extends(opts, { desc = 'Close buffer or window' }))

kset('n', '<leader><leader>q', function()
    vim.api.nvim_command('wa')
    vim.api.nvim_command('qa!')
end, extends(opts, { desc = 'quit neovim' }))

kset('n', ';rr', function()
    local cword = vim.fn.expand('<cword>')
    local search = vim.fn.input('Keywords > ', cword)
    vim.api.nvim_feedkeys(":Rg -F '" .. search .. "' -w", 'n', false)
end, extends(opts, { desc = 'ripgrep' }))

-- quickfix window
-- previously was mapped to <F4>

kset('n', '<F4>', M.toggle_quickfix, extends(opts, { desc = 'toggle quickfix' }))

-- buffer line
kset('n', '<leader>tc', function()
    vim.api.nvim_command('BufferLinePickClose')
end, extends(opts, { desc = 'BufferLinePickClose' }))
kset('n', '<leader>ts', function()
    vim.api.nvim_command('BufferLinePick')
end, extends(opts, { desc = 'BufferLinePick' }))

-- folding
---- map iterm with <cmd-[> to zc and map <cmd-]> to zo
kset('n', 'zf', function()
    local foldlevel = vim.fn.input('foldlevel > ')
    vim.api.nvim_command('setlocal foldlevel=' .. foldlevel)
    vim.api.nvim_command('normal zx')
end, extends(opts, { desc = 'set foldlevel' }))

kset('n', 'z=', 'zr', extends(opts, { desc = 'one more fold' }))
kset('n', 'z-', 'zm', extends(opts, { desc = 'one less fold' }))

-- Bookmark mappings
kset('n', '<Leader>m', '<Plug>BookmarkToggle', { desc = 'Toggle Bookmark' })
kset('n', '<Leader>l', '<Plug>BookmarkShowAll', { desc = 'Show All Bookmarks' })

-- Navigation mappings
kset({ 'n', 'v' }, 'H', '^', { desc = 'Move to beginning of line' })
kset({ 'n', 'v' }, 'L', '$', { desc = 'Move to end of line' })
kset('n', '[t', 'gT', { desc = 'Previous Tab' })
kset('n', ']t', 'gt', { desc = 'Next Tab' })
kset('n', '[b', ':bp<CR>', { desc = 'Previous Buffer' })
kset('n', ']b', ':bn<CR>', { desc = 'Next Buffer' })
kset('n', '[c', ':cp<CR>', { desc = 'Previous Quickfix' })
kset('n', ']c', ':cn<CR>', { desc = 'Next Quickfix' })

-- Insert mode mappings
kset('i', '<C-h>', '<Left>', { desc = 'Move Left in Insert Mode' })
kset('i', '<C-l>', '<Right>', { desc = 'Move Right in Insert Mode' })
kset('i', '<C-e>', '<End>', { desc = 'Move to End in Insert Mode' })
kset('i', '<C-a>', '<Home>', { desc = 'Move to Start in Insert Mode' })
kset('i', '<C-j>', '<Down>', { desc = 'Move cursor down in Insert Mode' })
kset('i', '<C-k>', '<Up>', { desc = 'Move cursor up in Insert Mode' })

-- Window navigation mappings
kset('n', 's-', '<C-w>s', { desc = 'Split window horizontally' })
kset('n', 's\\', '<C-w>v', { desc = 'Split window vertically' })
kset('n', '<C-w>-', '<C-w>s', { desc = 'Split window horizontally (alternative)' })
kset('n', '<C-w>\\', '<C-w>v', { desc = 'Split window vertically (alternative)' })
kset('n', 'sc', '<C-w>c', { desc = 'Close window' })
kset('n', 'ss', '<C-w>w', { desc = 'Switch window' })
kset('n', 'sh', '<C-w>h', { desc = 'Move to left window' })
kset('n', 'sl', '<C-w>l', { desc = 'Move to right window' })
kset('n', 'sj', '<C-w>j', { desc = 'Move to bottom window' })
kset('n', 'sk', '<C-w>k', { desc = 'Move to top window' })
kset('n', '<C-w><Left>', '<C-w>5<', { desc = 'Resize window left' })
kset('n', '<C-w><Right>', '<C-w>5>', { desc = 'Resize window right' })
kset('n', '<C-w><Up>', '<C-w>5+', { desc = 'Resize window up' })
kset('n', '<C-w><Down>', '<C-w>5-', { desc = 'Resize window down' })

-- Clipboard yank mapping
kset('v', '<leader>y', '"+y', { silent = true, desc = 'Yank to system clipboard' })

-- Terminal mode mapping
kset('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Prevent paste in visual mode from replacing unnamed buffer
kset('x', 'p', 'P', { desc = 'Prevent paste from replacing unnamed buffer' })

-- Search-related mappings
kset('n', 'n', 'nzz', { silent = true, desc = 'Next search result centered' })
kset('n', 'N', 'Nzz', { silent = true, desc = 'Previous search result centered' })
kset('n', '*', '*zz', { silent = true, desc = 'Search word under cursor forward centered' })
kset('n', '#', '#zz', { silent = true, desc = 'Search word under cursor backward centered' })
kset('n', 'g*', 'g*zz', { silent = true, desc = 'Search partial word forward centered' })

-- Disable highlighting search result on Enter key
kset('n', '<CR>', ':nohlsearch<CR><CR>', { silent = true, desc = 'Disable search highlight' })

-- Very magic search mappings
kset('n', '?', '?\\v', { desc = 'Very magic backward search' })
kset('n', '/', '/\\v', { desc = 'Very magic forward search' })
kset('n', ':g/', ':g/\\v', { desc = 'Very magic global search' })
kset('n', ':g//', ':g//', { desc = 'Repeat last global search' })

-- Line navigation mappings
kset('n', 'j', 'gj', { desc = 'Move down visually' })
kset('n', 'k', 'gk', { desc = 'Move up visually' })

-- ctrl + Left Button to open link
kset('n', '<C-LeftMouse>', M.open_url_under_cursor, { silent = true, desc = 'Open URL under mouse with Command+Click' })

-- reload lua config
kset('n', '<leader>R', M.reload_current_file, { desc = 'reload current lua file', silent = true })

-- tmux integration, using ALT+h/j/k/l to switch pane
kset('n', '<A-h>', function()
    M.navigate_or_tmux('h')
end, { silent = true })
kset('n', '<A-j>', function()
    M.navigate_or_tmux('j')
end, { silent = true })
kset('n', '<A-k>', function()
    M.navigate_or_tmux('k')
end, { silent = true })
kset('n', '<A-l>', function()
    M.navigate_or_tmux('l')
end, { silent = true })
-- Return true for tests/require checks
return M
