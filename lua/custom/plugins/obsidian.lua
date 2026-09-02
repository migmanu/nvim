return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/PKM',
      },
    },
    -- Let render-markdown.nvim own the in-buffer rendering; obsidian.nvim's own
    -- UI fights it (double-rendered/shifted checkboxes and icons).
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/93
    ui = { enable = false },
  },
}
