---@class Void
---@field config Void.config
---@field keymap Void.keymap
---@field event  Void.event
local M = {}

-- lazy load modules
setmetatable(M, {
  __index = function(t, k)
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("void." .. k)
    return rawget(t, k)
  end,
})

M.config = require("void.config")
M.keymap = require("void.keymap")
M.event = require("void.event")

return M
