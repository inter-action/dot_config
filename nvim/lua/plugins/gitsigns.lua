-- git
return {
    'lewis6991/gitsigns.nvim',
    version = 'v0.8.1',
    config = function()
        local gs = require('gitsigns')
        local on_attach = function(bufnr)
            local function map(mode, l, r, opts)
                -- default options in lua
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']g', function()
                if vim.wo.diff then
                    return ']g'
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return '<Ignore>'
            end, { expr = true, desc = 'Git: next_hunk' })

            map('n', '[g', function()
                if vim.wo.diff then
                    return '[g'
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return '<Ignore>'
            end, { expr = true, desc = 'Git: prev_hunk' })
        end

        gs.setup {
            on_attach = on_attach,
            signs = {
                add = { text = '▎' },
                change = { text = '▎' },
                delete = { text = '' },
                topdelete = { text = '' },
                changedelete = { text = '▎' },
                untracked = { text = '▎' },
            },
        }
    end,
}
