local M = {}

function M.supermod(mod, base)
  base = vim.tbl_deep_extend("error", base or {}, { __mod = {}})

  return setmetatable(base, {
    __index = function(t, k)
      if t.__mod[k] then
        return t.__mod[k]
      end

      t.__mod[k] = require(string.format("%s.%s", mod, k))

      return t.__mod[k]
    end,
  })
end

return M
