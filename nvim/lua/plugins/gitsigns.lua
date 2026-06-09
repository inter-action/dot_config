local function FzfIntegration()
    local gitsigns = require('gitsigns')
    local fzf = require('fzf-lua')

    local function fzf_gitsigns_commands()
        -- 1. Map user-friendly descriptions to actual gitsigns function calls
        local commands = {
            ['Stage Hunk'] = gitsigns.stage_hunk,
            ['Undo Stage Hunk'] = gitsigns.undo_stage_hunk,
            ['Reset Hunk'] = gitsigns.reset_hunk,
            ['Stage Buffer'] = gitsigns.stage_buffer,
            ['Reset Buffer'] = gitsigns.reset_buffer,
            ['Reset Buffer Index'] = gitsigns.reset_buffer_index,
            ['Preview Hunk'] = gitsigns.preview_hunk,
            ['Preview Hunk Inline'] = gitsigns.preview_hunk_inline,
            ['Blame Line'] = function()
                gitsigns.blame_line { full = true }
            end,
            ['Toggle Current Line Blame'] = gitsigns.toggle_current_line_blame,
            ['Diff This (Split)'] = gitsigns.diffthis,
            ['Diff This (Against ~)'] = function()
                gitsigns.diffthis('~')
            end,
            ['Toggle Deleted'] = gitsigns.toggle_deleted,
            ['Toggle Signs'] = gitsigns.toggle_signs,
            ['Toggle Line HL'] = gitsigns.toggle_linehl,
            ['Toggle Number HL'] = gitsigns.toggle_numhl,
            ['Toggle Word Diff'] = gitsigns.toggle_word_diff,
            ['Next Hunk'] = gitsigns.next_hunk,
            ['Prev Hunk'] = gitsigns.prev_hunk,
        }

        -- 2. Extract the keys to pass into fzf-lua
        local command_names = {}
        for name, _ in pairs(commands) do
            table.insert(command_names, name)
        end
        table.sort(command_names)

        -- 3. Launch fzf-lua picker
        fzf.fzf_exec(command_names, {
            prompt = 'Gitsigns Actions> ',
            winopts = {
                height = 0.4, -- Smaller, compact window for actions
                width = 0.4,
            },
            actions = {
                ['default'] = function(selected)
                    if not selected or #selected == 0 then
                        return
                    end

                    local choice = selected[1]
                    local func = commands[choice]

                    if func then
                        -- Safely execute the chosen gitsigns command
                        pcall(func)
                    end
                end,
            },
        })
    end

    -- Create the Neovim user command
    vim.api.nvim_create_user_command('GitsignsFzfCommands', fzf_gitsigns_commands, {})

    -- Keymap to trigger the picker (e.g., <leader>gc for "Git Commands")
    vim.keymap.set('n', ';g', ':GitsignsFzfCommands<CR>', { desc = 'Fuzzy find Gitsigns actions' })

    fzf.register_extension('gitsigns_commands', fzf_gitsigns_commands)
end

return {
    'lewis6991/gitsigns.nvim',
    version = 'v2.1.0',
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

        FzfIntegration()
    end,
}
