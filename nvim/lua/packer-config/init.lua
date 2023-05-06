

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- use 'editorconfig/editorconfig-vim'
    use 'jremmen/vim-ripgrep'

    use 'MattesGroeger/vim-bookmarks'

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- LSP
	use 'neovim/nvim-lspconfig'
	use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
	}
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{"nvim-tree/nvim-web-devicons"},
			--Please make sure you install markdown and markdown_inline parser
			{"nvim-treesitter/nvim-treesitter"}
		}
	})

	use 'onsails/lspkind.nvim' -- add Symbol kind to completion

    --- auto completes
    -- Completion framework:
    use 'hrsh7th/nvim-cmp' 

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'                             
    use 'hrsh7th/cmp-path'                              
    use 'hrsh7th/cmp-buffer'                            
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'   

    -- LSP: language specific
	use 'simrat39/rust-tools.nvim' -- rust


    -- motion
    use 'easymotion/vim-easymotion'
    use 'machakann/vim-highlightedyank'
    use 'tpope/vim-surround'

	-- telescope
	-- :checkhealth telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
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
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

	-- git
	use 'lewis6991/gitsigns.nvim'
	-- zen mode
	use "folke/zen-mode.nvim"

	use 'vimwiki/vimwiki'

    -- hydra
    use 'anuvyklack/hydra.nvim' 

    -- Simple plugins can be specified as strings
    --
end)