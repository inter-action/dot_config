return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },

    enable = true,
    -- opts = {},
    config = function()
        local fzflua = require('fzf-lua')
        local ok, utils = pcall(require, 'lua-utils')
        if not ok then
            vim.notify('lua-utils not available for fzf-lua mappings', vim.log.levels.WARN)
            return
        end
        local map = utils.map_func

        local no_preview_theme = {
            winopts = {
                preview = {
                    hidden = true
                }
            }
        }
        map("n", ";p", function() fzflua.files(no_preview_theme) end)
        map("n", ";o", function() fzflua.oldfiles(no_preview_theme) end)

        map("n", '<space>ds', fzflua.lsp_document_symbols, {
            desc =  'LSP: Document Symbols'
        })
        map("n", '<space>ws', fzflua.lsp_live_workspace_symbols, {
            desc =  'LSP: Workspace Symbols'
        })


        map("n", ";b", function() fzflua.buffers() end)

        -- use ;<Esc> to repeat find instead!
        map("n", ";r", function() fzflua.live_grep() end)
        map("n", ";c", function() fzflua.commands() end)
        map("n", ";ch", function() fzflua.command_history() end)
        map("n", ";a", function() fzflua.builtin() end)
        map('n', ';;', function() fzflua.resume() end)
    end
}