--
local function open_snippet_file()
    -- 1. Configuration: Change this to your actual snippet folder path
    local snippet_dir = vim.fn.stdpath('config') .. '/lua/snippets/'

    -- 2. Get current filetype (e.g., "lua", "rust", "python")
    local ft = vim.bo.filetype
    if ft == '' then
        vim.notify('No filetype detected for current buffer.')
        return
    end

    -- 3. Construct paths
    local target_file = snippet_dir .. ft .. '.lua'
    local fallback_file = snippet_dir .. 'all.lua'

    -- 4. Check if the specific snippet file exists
    if vim.fn.filereadable(target_file) == 1 then
        vim.cmd('edit ' .. target_file)
    elseif vim.fn.filereadable(fallback_file) == 1 then
        vim.notify("Snippet for '" .. ft .. "' not found. Opening all.lua instead.")
        vim.cmd('edit ' .. fallback_file)
    else
        vim.notify('Neither ' .. ft .. '.lua nor all.lua found in ' .. snippet_dir .. '\nPls create that file first.')
    end
end

-- Create the user command
vim.api.nvim_create_user_command('SnippetEdit', open_snippet_file, {
    desc = 'Open the LuaSnip file for the current filetype',
})

-- https://tui.ninja/neovim/customizing/user_commands/creating/
-- change tabwidth with one command

vim.api.nvim_create_user_command('ChangeTabWidth', function(opts)
    if not opts.args then
        return
    end

    local tabwidth = tonumber(opts.args)
    vim.o.shiftwidth = tabwidth
    vim.o.tabstop = tabwidth
    vim.o.softtabstop = tabwidth

    print(string.format('tabwidth set to: %s', tabwidth))
end, { nargs = 1 })

vim.api.nvim_create_user_command('AlignTextByChar', function(opts)
    if not opts.args then
        return
    end

    local char = opts.args

    if #char == 0 then
        return
    end

    -- Escape the character so '#' or '%' don't trigger Vim expansions
    local escaped_char = vim.fn.fnameescape(char)

    -- local cmd = string.format("column -t -s '%s' -o '%s'", char, char)
    -- -o option isn't supported by macos
    local cmd = string.format("column -t -s '%s'", escaped_char, escaped_char)

    -- Apply it to the current visual range
    vim.cmd(string.format("'<,'>!%s", cmd))
end, { range = true, nargs = 1 })

-- Moved from init.vim
-- Add any additional commands here

-- Example: Highlight search results centered
vim.api.nvim_create_user_command('NoHighlight', function()
    vim.cmd('nohlsearch')
end, {})
-- Custom user commands for Neovim
-- Define your own commands for quick actions

local cmd = vim.api.nvim_create_user_command

-- Reload Neovim config
cmd('ReloadConfig', 'source $MYVIMRC', {})

-- Create the user command
vim.api.nvim_create_user_command('SnippetEdit', open_snippet_file, {
    desc = 'Open the LuaSnip file for the current filetype',
})

return true
