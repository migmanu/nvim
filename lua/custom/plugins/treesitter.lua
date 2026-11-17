-- Treesitter parsers and highlighting.
--
-- On its `main` branch nvim-treesitter only installs parsers and queries;
-- Neovim itself does the highlighting, and only once `vim.treesitter.start()`
-- is called for a buffer. Without this, filetypes whose parser Neovim does not
-- bundle (e.g. Python) fall back to regex `:syntax` highlighting, which leaves
-- function calls uncoloured.
--
-- Building parsers needs `tree-sitter` (the CLI, 0.26.1+; installed as a
-- release binary in ~/.local/bin) and a C compiler.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false, -- main does not support lazy-loading
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install {
      'bash',
      'diff',
      'dockerfile',
      'git_config',
      'gitcommit',
      'hcl',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'sql',
      'terraform',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
    }

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        -- Skip filetypes without an installed parser
        if lang and vim.treesitter.language.add(lang) then
          pcall(vim.treesitter.start, args.buf, lang)
        end
      end,
    })
  end,
}
