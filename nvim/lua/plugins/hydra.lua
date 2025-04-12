local config = function()
    local Hydra = require("hydra")
    local gitsigns = require('gitsigns')
    local hydra_utils = require('hydra.keymap-util')
    local utils = require("../lua-utils")

    utils.map_func('n', '<Leader>hq', function()
        _G.Hydra:exit()
    end)

    local hint = [[
    _J_: next hunk         _K_: prev hunk      _d_: diff this         _D_: diff previous commit
    _s_: stage hunk        _b_: blame line     _B_: blame show full   _u_: undo last stage
    _p_: preview hunk      _S_: stage buffer   _r_: reset hunk        _/_: show base file
    ^
    ^ ^              _<Enter>_: Neogit              _q_: exit
    ]]


    Hydra({
        name = 'Git',
        hint = hint,
        config = {
            buffer = bufnr,
            color = 'pink',
            invoke_on_body = true,
            hint = {
                border = 'rounded'
            },
            on_enter = function()
                vim.cmd 'mkview'
                vim.cmd 'silent! %foldopen!'
                -- vim.bo.modifiable = false
                gitsigns.toggle_signs(true)
                gitsigns.toggle_linehl(true)
            end,
            on_exit = function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                hydra_utils.pcmd('loadview')
                vim.api.nvim_win_set_cursor(0, cursor_pos)
                hydra_utils.pcmd('normal zv')
                gitsigns.toggle_signs(false)
                gitsigns.toggle_linehl(false)
                gitsigns.toggle_deleted(false)
            end,
        },
        mode = { 'n', 'x' },
        body = '<leader>g',
        heads = {
            { 'J',
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gitsigns.next_hunk() end)
                    return '<Ignore>'
                end,
                { expr = true, desc = 'next hunk' } },
            { 'K',
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gitsigns.prev_hunk() end)
                    return '<Ignore>'
                end,
                { expr = true, desc = 'prev hunk' } },
            { 's',       ':Gitsigns stage_hunk<CR>',                        { silent = true, desc = 'stage hunk' } },
            { 'u',       gitsigns.undo_stage_hunk,                          { desc = 'undo last stage' } },
            { 'S',       gitsigns.stage_buffer,                             { desc = 'stage buffer' } },
            { 'p',       gitsigns.preview_hunk,                             { desc = 'preview hunk' } },
            { 'd',       function() gitsigns.diffthis() end,                { nowait = true, exit = true, desc = 'diff this' } },
            { 'D',       function() gitsigns.diffthis('~') end,             { nowait = true, exit = true, desc = 'diff previous commit' } },
            { 'b',       gitsigns.blame_line,                               { desc = 'blame' } },
            { 'r',       gitsigns.reset_hunk,                               { desc = 'reset hunk' } },
            { 'B',       function() gitsigns.blame_line { full = true } end, { desc = 'blame show full' } },
            { '/',       gitsigns.show,                                     { exit = true, desc = 'show base file' } }, -- show the base of the file
            { '<Enter>', '<Cmd>Neogit<CR>',                                 { exit = true, desc = 'Neogit' } },
            { 'q',       nil,                                               { exit = true, nowait = true, desc = 'exit' } },
        }
    })
end

return {
    -- hydra
    "anuvyklack/hydra.nvim",
    config = config,
    enabled = false,
    dependencies = {
        "lewis6991/gitsigns.nvim"
    }
}