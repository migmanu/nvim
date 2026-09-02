-- TomTom TODO helpers: terminal equivalent of the Obsidian Tasks query in
-- TomTom/TomTom_TODO.md. Matches markdown checkbox lines that carry the
-- #TomTom tag ON THE SAME LINE, anywhere in the vault (e.g. diary notes).
--
-- Keymaps:
--   <leader>st  -> Telescope: open TODO items ("- [ ] ... #TomTom")
--   <leader>sT  -> Telescope: done items ("- [x] ... #TomTom")
-- Command:
--   :TomtomTodos -> populate the quickfix list with all open #TomTom todos

local VAULT = vim.fn.expand '~/Documents/PKM'

-- rg regexes: checkbox at line start + #TomTom somewhere on the same line.
local OPEN_PAT = '^\\s*- \\[ \\] .*#TomTom\\b'
local DONE_PAT = '^\\s*- \\[[xX]\\] .*#TomTom\\b'

-- Use ripgrep for :grep so quickfix results are clean and fast.
if vim.fn.executable 'rg' == 1 then
  vim.opt.grepprg = 'rg --vimgrep --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

local function tomtom_grep(pattern, title)
  require('telescope.builtin').grep_string {
    search = pattern,
    use_regex = true,
    search_dirs = { VAULT },
    prompt_title = title,
  }
end

vim.keymap.set('n', '<leader>st', function()
  tomtom_grep(OPEN_PAT, 'TomTom TODO (open)')
end, { desc = '[S]earch TomTom [t]odos (open)' })

vim.keymap.set('n', '<leader>sT', function()
  tomtom_grep(DONE_PAT, 'TomTom TODO (done)')
end, { desc = '[S]earch TomTom [T]odos (done)' })

-- Quickfix version: :TomtomTodos then jump through open #TomTom todos.
-- Run rg directly (list-form, no shell) and build the quickfix list, so the
-- '#' in the pattern isn't expanded as vim's alternate-file token (E194).
vim.api.nvim_create_user_command('TomtomTodos', function()
  local lines = vim.fn.systemlist { 'rg', '--vimgrep', '--smart-case', '--', OPEN_PAT, VAULT }
  vim.fn.setqflist({}, ' ', { title = 'TomTom TODO (open)', lines = lines, efm = '%f:%l:%c:%m' })
  vim.cmd 'copen'
end, { desc = 'Load open #TomTom todos into the quickfix list' })

return {}