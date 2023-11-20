---Provider abstractions.
---@class void.util.provider
local M = {}

---Creates a new basic provider.
---@param  default table|nil The default provider.
---@return table
function M.new_basic(default)
  local key = {}

  return setmetatable({
    [key] = default,
    override = function(self, value)
      self[key] = value
    end,
  }, {
    __index = function(t, k)
      if not t[key] then
        Void.core.log.warn("No default value set for provider")
      else
        return t[key][k]
      end
    end,
  })
end

return M
