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