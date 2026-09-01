return {
    {
        'nvim-treesitter/nvim-treesitter',
        -- Use main branch for Neovim 0.12+ compatibility (old master branch is deprecated)
        branch = 'main',
        build = ':TSUpdate',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            local ts = require('nvim-treesitter')
            ts.setup {
                -- Automatically install and maintain these language parsers
                ensure_installed = {
                    'c',
                    'cpp',
                    'rust',
                    'vim',
                    'lua',
                    'python',
                    'go',
                    'typescript',
                    'javascript',
                    'tsx',
                    'toml',
                    'json',
                    'html',
                    'markdown',
                    'markdown_inline',
                },
                -- Disable plugin-built highlight & indent (Neovim 0.12 uses native Treesitter)
                highlight = { enable = false },
                indent = { enable = false },
            }

            -- Incremental Treesitter selection keymaps (native Neovim 0.12 features)
            vim.keymap.set('n', '<c-space>', 'v', { desc = 'Start visual selection' })
            -- remap = true,
            --  Enables recursive mapping resolution. Neovim interprets `an` as
            --  an existing defined mapping (Neovim 0.12 native treesitter text-object),
            --  executes its actual behavior (expand syntax node).
            vim.keymap.set('v', '<c-space>', 'an', { desc = 'Expand syntax node', remap = true })
            -- vim.keymap.set('v', '<c-s>', 'as', { desc = 'Expand syntax scope', remap = true, })
            vim.keymap.set('v', '<bs>', 'in', { desc = 'Shrink syntax node', remap = true })

            -- Disable Treesitter for vimdoc and large JavaScript files
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'javascript', 'vimdoc' },
                callback = function(args)
                    local buf = args.buf
                    local file_path = vim.api.nvim_buf_get_name(buf)

                    -- Completely disable Treesitter for vimdoc files
                    if vim.bo[buf].filetype == 'vimdoc' then
                        vim.treesitter.stop(buf)
                        return
                    end

                    -- Set file size limit: 100 KB
                    local max_file_size = 100 * 1024
                    local ok, file_stat = pcall(vim.uv.fs_stat, file_path)
                    -- Disable Treesitter if file exceeds size limit
                    if ok and file_stat and file_stat.size > max_file_size then
                        vim.treesitter.stop(buf)
                    end
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesitter-context').setup {
                enable = true,
                max_lines = 3,
            }
        end,
    },
}
