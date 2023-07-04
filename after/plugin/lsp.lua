--[[vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'emmet_ls',
})

local cmp = require'cmp'

 cmp.setup(
{
    mapping = {
        ["<CR>"] = cmp.config.disable,
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm()
    }
    }
) 

lsp.nvim_workspace()

lsp.setup()]]
