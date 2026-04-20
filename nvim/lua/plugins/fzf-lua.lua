return {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },

    enable = true,
    -- opts = {},
    config = function()
        local fzflua = require('fzf-lua')
        local utils = require('lua-utils')

        local kmap = vim.keymap.set

        fzflua.setup {
            winopts = {
                preview = {
                    layout = 'vertical',
                    vertical = 'down:45%',
                },
            },
        }

        local no_preview_theme = {
            winopts = {
                preview = {
                    hidden = true,
                },
            },
        }

        local bottom_preview_theme = {
            winopts = {
                preview = {
                    layout = 'vertical',
                    vertical = 'down:50%',
                    hidden = false, -- ensure preview didn't hidden
                },
            },
        }

        -- Exact match: Precede with a single quote (e.g., 'filename).
        -- Prefix-exact: Precede with ^ (e.g., ^src).
        -- Suffix-exact: Append $ (e.g., .lua$).
        -- Inverse match: Precede with ! (e.g., !node_modules).

        local function open_files()
            fzflua.files(utils.extends(no_preview_theme, {
                header = "::match syntax, ::exact '<word> "
                    .. '::prefix ^<word>  ::suffix <word>$ ::inverse !<word> \n' -- break line
                    .. '::toggle hidden <A-h>',
            }))
        end

        kmap('n', ';p', open_files, { desc = 'Fzf: Find files' })
        -- for some reason <M-p> not working
        -- kmap('n', '<M-p>', open_files, { desc = 'Fzf: Find files' })

        kmap('n', ';o', function()
            fzflua.oldfiles(no_preview_theme)
        end, { desc = 'Fzf: Recent files' })

        kmap('n', '<space>ds', fzflua.lsp_document_symbols, {
            desc = 'LSP: Document Symbols',
        })

        kmap('n', '<space>ws', fzflua.lsp_live_workspace_symbols, {
            desc = 'LSP: Workspace Symbols',
        })

        kmap('n', ';b', function()
            fzflua.buffers(no_preview_theme)
        end, { desc = 'Fzf: Opened buffers' })

        kmap('n', ';r', function()
            fzflua.live_grep {
                header = '::Syntax <keyword> -- <glob> <!neg glob>  ::Example lua -- *.ts',
            }
        end, { desc = 'Fzf: Live grep (Search text)' })

        kmap('n', ';c', function()
            fzflua.commands(no_preview_theme)
        end, { desc = 'Fzf: Neovim commands' })

        kmap('n', ';h', function()
            fzflua.command_history(no_preview_theme)
        end, { desc = 'Fzf: Command history' })

        kmap('n', ';a', function()
            fzflua.builtin()
        end, { desc = 'Fzf: Built-in pickers' })

        kmap('n', ';;', function()
            fzflua.resume()
        end, { desc = 'Fzf: Resume last picker' })
    end,
}
