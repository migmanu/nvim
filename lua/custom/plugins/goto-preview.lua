return {
  'rmagatti/goto-preview',
  dependencies = { 'rmagatti/logger.nvim' },
  event = 'BufEnter',
  ---@type table
  opts = {
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
  },
}
