---Module utilities.
---@class void.util.module
local M = {}

---Creates a new cached supermodule.
---@param  mod  string     # The module.
---@param  base table|nil  # Optional base table.
---@return      table      # The supermodule.
function M.make(mod, base)
  if not base then
    base = { _mod = {} }
  else
    base._mod = base._mod or {}
  end

  local metatable = vim.tbl_extend("force", getmetatable(base) or {}, {
    __index = function(t, k)
      if t._mod[k] then
        return t._mod[k]
      end

      t._mod[k] = require(string.format("%s.%s", mod, k))

      return t._mod[k]
    end,
  })

  return setmetatable(base, metatable)
end

return M
