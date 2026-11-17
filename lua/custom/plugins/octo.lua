return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  init = function()
    -- Octo's review placeholder ("octo/null") and diff buffers are regular,
    -- non-scratch buffers, so they get swap files. When a review is open in
    -- two nvims, or nvim was killed, every new review then warns that a swap
    -- file exists. Their content comes from GitHub, so a swap file is useless.
    vim.api.nvim_create_autocmd('BufFilePost', {
      group = vim.api.nvim_create_augroup('octo-no-swap', { clear = true }),
      pattern = { '*/octo/null', 'octo://*/review/*' },
      callback = function(args)
        vim.bo[args.buf].swapfile = false
      end,
    })
  end,
  opts = {
    -- or "fzf-lua" or "snacks" or "default"
    picker = 'telescope',
    -- bare Octo command opens picker of commands
    enable_builtin = true,
    -- In reviews, show the right (PR) side as the real file on disk instead of
    -- an octo:// scratch buffer, so LSP (gd, K, references) works. Needs the PR
    -- branch checked out; Octo offers to check it out when the review starts.
    use_local_fs = true,
  },
  keys = {
    {
      '<leader>oi',
      '<CMD>Octo issue list<CR>',
      desc = 'List GitHub Issues',
    },
    {
      '<leader>op',
      '<CMD>Octo pr list<CR>',
      desc = 'List GitHub PullRequests',
    },
    {
      '<leader>od',
      '<CMD>Octo discussion list<CR>',
      desc = 'List GitHub Discussions',
    },
    {
      '<leader>on',
      '<CMD>Octo notification list<CR>',
      desc = 'List GitHub Notifications',
    },
    {
      '<leader>os',
      function()
        require('octo.utils').create_base_search_command { include_current_repo = true }
      end,
      desc = 'Search GitHub',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    -- OR "ibhagwan/fzf-lua",
    -- OR "folke/snacks.nvim",
    'nvim-tree/nvim-web-devicons', -- optional if file_panel.icons is a function
  },
}
