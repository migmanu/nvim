return {
  'rmagatti/goto-preview',
  dependencies = { 'rmagatti/logger.nvim' },
  event = 'BufEnter',
  -- opts is a function so telescope.themes is required when goto-preview loads,
  -- not while lazy reads the specs (telescope.lua sorts after this file, so its
  -- spec isn't known yet at that point and the require fails).
  opts = function()
    return {
      width = 120,
      height = 25,
      border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' },
      default_mappings = true,
      debug = false,
      opacity = nil,
      resizing_mappings = false,
      post_open_hook = nil,
      post_close_hook = nil,
      references = {
        telescope = require('telescope.themes').get_dropdown { hide_preview = false },
      },
      focus_on_open = true,
      dismiss_on_move = false,
      force_close = true,
      bufhidden = 'wipe',
    }
  end,
}
