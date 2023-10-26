return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'editorconfig/editorconfig-vim'
    use 'jremmen/vim-ripgrep'

    use 'MattesGroeger/vim-bookmarks'

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter"
    })

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim'}

    -- TODO: remove ?
    -- use {
    --     'j-hui/fidget.nvim',
    --     tag = 'legacy',
    --     config = function()
    --         require("fidget").setup {
    --             -- options
    --         }
    --     end
    -- }

    -- use({
    -- 	"glepnir/lspsaga.nvim",
    -- 	branch = "main",
    -- 	requires = {
    -- 		{"nvim-tree/nvim-web-devicons"},
    -- 		--Please make sure you install markdown and markdown_inline parser
    -- 		{"nvim-treesitter/nvim-treesitter"}
    -- 	}
    -- })

    ---- lua lsp
    -- use 'folke/neodev.nvim',
    

    use 'onsails/lspkind.nvim' -- add Symbol kind to completion

    --- auto completes
    -- Completion framework:
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    ----- cmp: Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    ----- cmp: snippets
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*"
    })
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"

    -- LSP: language specific
    -- use 'simrat39/rust-tools.nvim' -- rust

    -- motion
    use 'easymotion/vim-easymotion'
    use 'tpope/vim-surround'

    -- telescope
    -- :checkhealth telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- auto pair
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use 'alvan/vim-closetag'

    -- change case
    use "johmsalas/text-case.nvim"

    -- ui enhancement
    use "EdenEast/nightfox.nvim"
    use 'kyazdani42/nvim-web-devicons'
    -- nvim tree
    -- icon issue: https://github.com/ryanoasis/vim-devicons/wiki/Installation
    use 'kyazdani42/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'
    -- notify
    use 'rcarriga/nvim-notify'
    -- tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }

    -- git
    use 'lewis6991/gitsigns.nvim'
    -- zen mode
    use "folke/zen-mode.nvim"

    use 'vimwiki/vimwiki'

    -- hydra
    use 'anuvyklack/hydra.nvim'

    use 'ThePrimeagen/harpoon'

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    }
    -- Simple plugins can be specified as strings
    --
end)