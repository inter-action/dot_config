-- https://tui.ninja/neovim/customizing/user_commands/creating/
-- change tabwidth with one command
vim.api.nvim_create_user_command(
    'ChangeTabWidth',
    function(opts)
        if not opts.args then
            return
        end

        local tabwidth = tonumber(opts.args)
        vim.o.shiftwidth = tabwidth
        vim.o.tabstop = tabwidth
        vim.o.softtabstop = tabwidth

        print(string.format("tabwidth set to: %s", tabwidth))
    end,
    { nargs = 1 }
)



vim.api.nvim_create_user_command(
    'AlignTextByChar',
    function(opts)
        if not opts.args then
            return
        end

        local char = opts.args

        if opts.range == 0 then
            return
        end

        local cmd = ":'<,'>!column -t -s " .. char .. " -o " .. "'" .. char .. "'"
        vim.api.nvim_command(cmd)
    end,
    { nargs = 1, range = true }
)

-- Moved from init.vim
-- Add any additional commands here

-- Example: Highlight search results centered
vim.api.nvim_create_user_command(
    'NoHighlight',
    function()
        vim.cmd('nohlsearch')
    end,
    {}
)
-- Custom user commands for Neovim
-- Define your own commands for quick actions

local cmd = vim.api.nvim_create_user_command

-- Reload Neovim config
cmd('ReloadConfig', 'source $MYVIMRC', {})

return true