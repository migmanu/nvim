-- Plugins that need no configuration beyond their spec line.
return {
  -- cpp highlight
  'bfrg/vim-c-cpp-modern',

  -- why not? (<leader>fml, see init.lua keymaps)
  'eandrju/cellular-automaton.nvim',

  -- git plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
