-- Inherit full login-shell PATH so git hooks (e.g. pre-commit) can find their tools
-- when lazygit is launched from inside Neovim. This matters when Neovim is started
-- outside a terminal shell; from a terminal the inherited PATH already matches.
-- Fetched asynchronously: a blocking login-shell spawn cost ~150-240ms per startup.
-- Merge rather than replace: by the time this lands, plugins (mason) have already
-- prepended their own dirs to PATH, and overwriting it would drop them.
if vim.fn.has 'unix' == 1 and vim.fn.executable 'zsh' == 1 then
  vim.system({ 'zsh', '-l', '-c', 'echo -n $PATH' }, { text = true }, function(out)
    if out.code == 0 and out.stdout and out.stdout ~= '' then
      vim.schedule(function()
        local dirs = vim.split(vim.env.PATH or '', ':', { trimempty = true })
        local seen = {}
        for _, d in ipairs(dirs) do
          seen[d] = true
        end
        for _, d in ipairs(vim.split(out.stdout, ':', { trimempty = true })) do
          if not seen[d] then
            seen[d] = true
            table.insert(dirs, d)
          end
        end
        vim.env.PATH = table.concat(dirs, ':')
      end)
    end
  end)
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- No remote plugins in use: skip probing for the Python/Node/Perl/Ruby hosts.
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- conceallevel for obsidian
vim.opt_local.conceallevel = 2

--line numbers and relative numbers
vim.opt.nu = true
-- vim.opt.relativenumber = true

-- highlight current line
vim.opt.cursorline = true

-- 4 space indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.conceallevel = 1

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- move selected text in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- toggle lsp warnings
vim.keymap.set('n', '<leader>dv', function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config { virtual_text = not current }
  print('Diagnostics virtual text: ' .. (not current and 'ON' or 'OFF'))
end, { desc = 'Toggle Diagnostics Virtual Text' })

-- Toggle spellcheck in English
vim.keymap.set('n', '<leader>ue', function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  vim.opt_local.spelllang = 'en_us'
  print('Spellcheck: ' .. (vim.opt_local.spell:get() and 'ON' or 'OFF') .. ' (Language: English)')
end, { desc = 'Toggle Spellcheck (English)' })

-- Toggle spellcheck in Spanish
vim.keymap.set('n', '<leader>uS', function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
  vim.opt_local.spelllang = 'es'
  print('Spellcheck: ' .. (vim.opt_local.spell:get() and 'ON' or 'OFF') .. ' (Language: Spanish)')
end, { desc = 'Toggle Spellcheck (Spanish)' })

-- fuck it all
vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keep cursor vertically centered (replaces stay-centered.nvim)
local _stay_centered_skip = { lua = true, typescript = true, terminal = true }
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('stay-centered', { clear = true }),
  callback = function()
    local mode = vim.fn.mode()
    if mode == 't' or _stay_centered_skip[vim.bo.filetype] or vim.bo.buftype == 'terminal' then
      return
    end
    local line = vim.api.nvim_win_get_cursor(0)[1]
    if line ~= vim.b.last_line then
      vim.cmd 'normal! zz'
      vim.b.last_line = line
    end
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Every plugin spec lives in its own file under lua/custom/plugins/
  -- (one file per plugin; misc.lua holds the ones that need no config).
  { import = 'custom.plugins' },
}, {
  -- No plugin needs luarocks; skip the hererocks/luarocks setup and its health errors.
  rocks = { enabled = false },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
