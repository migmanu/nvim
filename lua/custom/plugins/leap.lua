return {
  url = 'https://codeberg.org/andyg/leap.nvim',
  enabled = true,
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap Forward to' },
    { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap Backward to' },
    { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from Windows' },
  },
  config = function(_, opts)
    local leap = require 'leap'
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    -- Set keymaps manually to override default 's' behavior
    vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
      leap.leap { target_windows = { vim.api.nvim_get_current_win() } }
    end, { desc = 'Leap Forward to' })
    vim.keymap.set({ 'n', 'x', 'o' }, '<leader>sb', function()
      leap.leap { backward = true, target_windows = { vim.api.nvim_get_current_win() } }
    end, { desc = 'Leap Backward to' })
  end,
}
