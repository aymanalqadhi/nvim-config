---@class Void
---@field config Void.config
---@field keymap Void.keymap
---@field event  Void.event
---@field buf    Void.buf
local M = {}

-- lazy load modules
setmetatable(M, {
  __index = function(t, k)
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("void." .. k)
    return rawget(t, k)
  end,
})

return M
