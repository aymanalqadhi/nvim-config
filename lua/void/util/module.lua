---Module utilities.
---@class Void.util.module
local M = {}

---Creates a new cached supermodule.
---@param  mod  string     # The module.
---@return      table      # The supermodule.
function M.make(mod, base)
  return setmetatable({ _mod = base or {}}, {
    __index = function(t, k)
      if t._mod[k] then
        return t._mod[k]
      end

      t._mod[k] = require(mod .. "." .. k)

      return t._mod[k]
    end,
  })
end

return M
