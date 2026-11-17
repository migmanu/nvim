return {
  url = 'https://codeberg.org/andyg/leap.nvim',
  enabled = true,
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap (both directions)' },
    { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap Backward to' },
    { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from Windows' },
  },
  config = function(_, opts)
    local leap = require 'leap'
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    -- Use leap's own <Plug> maps. Passing a window list (as <Plug>(leap) does)
    -- makes leap search that window in both directions and ignore `backward`,
    -- so a hand-written "backward in this window" call finds nothing.
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)', { desc = 'Leap (both directions)' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', { desc = 'Leap Backward to' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)', { desc = 'Leap from Windows' })
  end,
}
