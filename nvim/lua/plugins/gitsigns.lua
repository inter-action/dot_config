-- git
return {
    'lewis6991/gitsigns.nvim',
    version = "v0.8.1",
    config = function()
        local gs = require('gitsigns')
        local on_attach = function(bufnr)
            -- local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                -- default options in lua
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr = true})

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr = true})
        end

        gs.setup({
            on_attach = on_attach,
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        })
    end
}
