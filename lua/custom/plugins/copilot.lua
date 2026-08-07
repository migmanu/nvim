return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    init = function()
      -- Disable the default <Tab> mapping
      vim.g.copilot_no_tab_map = true

      -- Optional: disable for some filetypes
      vim.g.copilot_filetypes = {
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        yaml = false,
        ["."] = false,
      }
    end,
    config = function()
      -- Accept suggestion with Alt+l
      vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        silent = true,
      })

      -- Next suggestion
      vim.keymap.set("i", "<M-n>", "<Plug>(copilot-next)")

      -- Previous suggestion
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)")

      -- Dismiss suggestion
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)")
    end,
  },
}
