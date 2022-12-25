-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  --rose-pine
  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })

  --treesitter
  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
    }

  -- trewsitter playground
  use('nvim-treesitter/playground')

  -- harpoon
  use('https://github.com/ThePrimeagen/harpoon')

  --undotree
  use('https://github.com/mbbill/undotree')

  --fugitive
  use('https://github.com/tpope/vim-fugitive')

end)