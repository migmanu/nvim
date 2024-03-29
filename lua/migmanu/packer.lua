-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

	-- 42 header
	use '42Paris/42header'

	-- 42 norminette
	use 'hardyrafael17/norminette42.nvim'

	-- nvim-dap
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'

	use 'jay-babu/mason-nvim-dap.nvim'
	-- transparetn nvim
	use 'xiyaowong/transparent.nvim'

    --telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- one dark pro theme
    use "olimorris/onedarkpro.nvim"

    --treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    --autopairs
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use {
        "windwp/nvim-ts-autotag",
        wants = "nvim-treesitter",
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup { enable = true }
        end,
    }

    -- harpoon
    use('https://github.com/ThePrimeagen/harpoon')

    --undotree
    use('https://github.com/mbbill/undotree')

    --fugitive
    use('https://github.com/tpope/vim-fugitive')

    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    --nvm-web-icons
    use 'nvim-tree/nvim-web-devicons'

    --indent-blanklien
    use 'lukas-reineke/indent-blankline.nvim'

    --nvim-commaround
    use 'gennaro-tedesco/nvim-commaround'

    use {
        "williamboman/mason.nvim",
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'jose-elias-alvarez/null-ls.nvim' },
        },
        config = function ()
            require("mason").setup()
            require("mason-lspconfig").setup()
			require("mason-nvim-dap").setup()
        end,
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    
    --lsp-zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    
    --icons for lsp completions
    use 'onsails/lspkind.nvim'

    --codicons
    use 'mortepau/codicons.nvim'

    --trouble [diagnosis]
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

	use { 'gen740/SmoothCursor.nvim',
		config = function()
			require('smoothcursor').setup()
		end
	}

    --lsp-colors
    use 'folke/lsp-colors.nvim'

    --todo-comments
    use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}


end)
