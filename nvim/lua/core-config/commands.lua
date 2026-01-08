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

local function get_visual_selection()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    return table.concat(lines, '\n')
end


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