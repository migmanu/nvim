-- claude_show: lets an external Claude Code session point at code in this Neovim.
-- Driven over Neovim's RPC socket by ~/.local/bin/nvim-show (see the nvim-show skill).
-- Highlights ranges, adds end-of-line notes, and loads multi-spot walk-throughs into the quickfix list.
local M = {}
local ns = vim.api.nvim_create_namespace("claude_show")

local function file_window()
  -- prefer a normal file window in the current tab (skip terminals, sidebars, floats, dashboard)
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local b = vim.api.nvim_win_get_buf(w)
    if vim.api.nvim_win_get_config(w).relative == "" and vim.bo[b].buftype == "" then
      return w
    end
  end
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(w).relative == "" and vim.bo[vim.api.nvim_win_get_buf(w)].buftype ~= "terminal" then
      return w
    end
  end
  return vim.api.nvim_get_current_win()
end

function M.clear()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(b) then
      vim.api.nvim_buf_clear_namespace(b, ns, 0, -1)
    end
  end
end

local function mark(buf, s, e, note)
  local last = vim.api.nvim_buf_line_count(buf)
  s = math.max(1, math.min(s, last))
  e = math.max(s, math.min(e or s, last))
  vim.api.nvim_buf_set_extmark(buf, ns, s - 1, 0, { end_row = e, hl_group = "Visual", hl_eol = true })
  if note and note ~= "" then
    vim.api.nvim_buf_set_extmark(buf, ns, s - 1, 0, {
      virt_text = { { "◀ " .. note, "DiagnosticInfo" } },
      virt_text_pos = "eol",
    })
  end
  return s
end

-- spots: list of { file=, start=, ["end"]=, note= }. One spot = jump there; several = quickfix walk-through.
function M.show(spots)
  vim.cmd("stopinsert")
  M.clear()
  vim.api.nvim_set_current_win(file_window())
  local qf = {}
  for i, sp in ipairs(spots) do
    local buf = vim.fn.bufadd(sp.file)
    vim.fn.bufload(buf)
    vim.bo[buf].buflisted = true
    local s = mark(buf, sp.start, sp["end"], sp.note)
    qf[#qf + 1] = { bufnr = buf, lnum = s, text = sp.note or "" }
    if i == 1 then
      vim.api.nvim_win_set_buf(0, buf)
      vim.api.nvim_win_set_cursor(0, { s, 0 })
      vim.cmd("normal! zz")
    end
  end
  if #spots > 1 then
    vim.fn.setqflist({}, " ", { title = "Claude walk-through", items = qf })
    vim.notify(("Claude: %d spots in quickfix — :cnext / :cprev, <leader>ax clears"):format(#spots))
  end
  vim.cmd("redraw!")
  return "ok"
end

-- entry point for the RPC call: reads a JSON file written by nvim-show
function M.from_json(path)
  local req = vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
  if req.clear then
    M.clear()
    vim.cmd("redraw!")
    return "cleared"
  end
  return M.show(req.spots)
end

vim.keymap.set("n", "<leader>ax", function()
  M.clear()
end, { desc = "Clear Claude highlights" })

return M
