

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'editorconfig/editorconfig-vim'
    use 'jremmen/vim-ripgrep'

    use 'jiangmiao/auto-pairs'
    use 'MattesGroeger/vim-bookmarks'

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- LSP
	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-buffer' -- 
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin
	use 'onsails/lspkind.nvim' -- add Symbol kind to completion
	use 'glepnir/lspsaga.nvim' -- lsp ui

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
	use 'romgrk/barbar.nvim'

    -- Simple plugins can be specified as strings
    --
end)
