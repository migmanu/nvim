return {
  'evelez7/auto-switch-theme.nvim',
  lazy = false,
  priority = 900, -- load after catppuccin (priority 1000) so its colorschemes exist
  dependencies = { 'catppuccin' },
  opts = {
    light = 'catppuccin-latte',
    dark = 'catppuccin', -- default flavour (mocha)
  },
  -- The plugin only switches colorscheme in reaction to `OptionSet background`;
  -- it never applies a theme on startup. Apply one explicitly here so we don't
  -- depend on the terminal's OSC 11 background auto-detection firing.
  config = function(_, opts)
    require('auto-switch-theme').setup(opts)
    vim.cmd.colorscheme(vim.o.background == 'dark' and opts.dark or opts.light)
  end,
}
