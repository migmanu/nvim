-- markdown preview:
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- Fix bullets/icons rendering right-shifted in some terminals/fonts.
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/93
    bullet = { right_pad = 1 },
    -- No LaTeX math in notes; skip the latex parser / latex2text dependency.
    latex = { enabled = false },
  },
}
