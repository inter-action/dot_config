require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        "c", "cpp", "rust", "vim", "lua", "python", "go", "typescript",
        "javascript", "tsx", "toml", "json", "html", "markdown",
        "markdown_inline", "swift"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- auto_install = true,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>'
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner'
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        },
        swap = {
            enable = true,
            swap_next = {['<leader>a'] = '@parameter.inner'},
            swap_previous = {['<leader>A'] = '@parameter.inner'}
        }
    },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    ident = {enable = true},
    rainbow = {enable = true, extended_mode = true, max_file_lines = 1000},
    autopairs = {enable = true},
    autotag = {enable = true}
}
