local Hydra = require("hydra")
local pcmd = require('hydra.keymap-util').pcmd
local cmd = require('hydra.keymap-util').cmd


local hint = [[
 _J_: next error        _K_: pre error
 _a_: code action       _r_: rename           _s_: show buf diagnostics   _i_: incoming calls
 _o_: outgoing calls     
 ^
 ^ ^              _q_: exit
]]

Hydra({
    name = 'LspSaga',
    hint = hint,
    config = {
        buffer = bufnr,
        color = 'pink',
        invoke_on_body = true,
        hint = {
            border = 'rounded',
        },
    },
    mode = {'n','v'},
    body = '<leader>s',
    heads = {
        -- do i need these? maybe just for reference
        { 'J', function()
            require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'next error' } },
        { 'K', function()
            require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end, { desc = 'pre error' } },
        { 'a', '<cmd>Lspsaga code_action<CR>', { exit = true, desc = 'code action' } },
        { 'r', '<cmd>Lspsaga rename<CR>', { exit = true, desc = 'rename' } },
        { 's', '<cmd>Lspsaga show_buf_diagnostics<CR>', { exit = true, desc = 'show_buf_diagnostics' } },
        { 'i', '<cmd>Lspsaga incoming_calls<CR>', { desc = 'incoming_calls' } },
        { 'o', '<cmd>Lspsaga outgoing_calls<CR>', { desc = 'outgoing_calls' } },
        { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
    }
})