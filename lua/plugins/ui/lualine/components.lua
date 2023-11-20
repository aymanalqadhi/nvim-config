local M = {}

function M.macro()
  local function get_register()
    local reg = vim.fn.reg_recording()
    if reg == "" then
      return ""
    end
    return "REC @" .. reg
  end

  return {
    get_register,
    icon = require("config.icons").misc.record,
    color = "Constant",
  }
end

return M
