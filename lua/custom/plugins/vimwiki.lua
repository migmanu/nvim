return {
  'vimwiki/vimwiki',

  -- VERY IMPORTANT: globals must be set before plugin loads
  init = function()
    vim.g.vimwiki_list = {
      {
        path = vim.fn.expand '~/Documents/PKM/',
        syntax = 'markdown',
        ext = '.md',
      },
    }

    -- Only treat files in the wiki path as Vimwiki
    vim.g.vimwiki_global_ext = 0

    -- Disable features that cause friction with Obsidian
    vim.g.vimwiki_auto_chdir = 0
    vim.g.vimwiki_auto_header = 0
    vim.g.vimwiki_table_mappings = 0
    vim.g.vimwiki_markdown_link_ext = 0

    -- Disable diary/calendar unless explicitly wanted
    -- vim.g.vimwiki_use_calendar = 0
    -- vim.g.vimwiki_diary_months = {}
    vim.g.vimwiki_diary_header = '# %Y-%m-%d'

    -- Optional: safer defaults
    vim.g.vimwiki_create_link = 1
    vim.g.vimwiki_filename_space_char = '-'
  end,

  keys = {
    { '<leader>ww', '<cmd>VimwikiIndex<CR>', desc = 'Vimwiki: Index' },
    { '<leader>wf', '<Plug>VimwikiFollowLink', desc = 'Vimwiki: Follow link' },
    { '<leader>wb', '<Plug>VimwikiGoBackLink', desc = 'Vimwiki: Back' },
  },
}
