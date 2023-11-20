local M = {}

-- default keymaps options
M.default_options = {
  silent = true,
  noremap = true,
}

--- Sets a keymap.
--
---@param mode (string|table)    The mode(s) to set the keymap on.
---@param lhs  (string)          The key sequence that should trigger.
---@param rhs  (string|function) The vimcmd/lua function to execute.
---@param opts (table|nil)       Options to pass to `vim.keymap.set`.
function M.set(mode, lhs, rhs, opts)
  -- set default options if not set
  if not opts then
    opts = M.default_options
  else
    opts = vim.tbl_deep_extend("force", M.default_options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

return M
