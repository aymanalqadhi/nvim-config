local M = {}

M.mode_labels = {
  NORMAL = "  ",
  INSERT = "  ",
  VISUAL = " 󰘖 ",
  ["V-LINE"] = " 󰡏 ",
  ["V-BLOCK"] = " 󰁌 ",
  REPLACE = "  ",
  ["V-REPLACE"] = "  ",
  ENTER = "  ",
  MORE = "  ",
  SELECT = "  ",
  COMMAND = "  ",
  SHELL = "  ",
  TERM = "  ",
  NONE = " ⏺︎ ",
  CONFIRM = " ᐅ ",
}

function M.fg(name)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end

function M.format_mode(mode)
  return M.mode_labels[mode]
end

function M.macro_label()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return "REC @" .. reg
end

function M.noice_component(field, hl)
  return {
    function()
      local status = require("noice").api.status[field] ---@type NoiceStatus
      return status.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status[field].has()
    end,
    color = hl,
  }
end

function M.lsp_clients_string()
  local clients = vim.lsp.get_clients()
  local names = {}

  for _, client in pairs(clients) do
    table.insert(names, client.name)
  end

  return table.concat(names, ", ")
end

return M
