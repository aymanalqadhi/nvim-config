--- Key mapping utilities
---@class Void.keymap
local M = {}

---@class VoidMapping
---@field mode   string|table|nil # The mode(s) the mapping should apply to.
---@field prefix string|nil       # The key combination required to invoke the mapping.
---@field opts   table|nil        # Options to pass to `vim.keymap.set`.

local function prepare_mapping(map)
  local rhs = table.remove(map, 2)
  local lhs = table.remove(map, 1)
  local mode = nil

  if map.mode then
    mode = map.mode; map.mode = nil
  end

  if map.expr and map.replace_keycodes ~= false then
    map.replace_keycodes = true
  end

  if map.remap == nil then
    map.noremap = true
  else
    map.noremap = not map.remap
    map.remap = nil
  end

  if type(rhs) == "function" then
    map.callback = rhs
    rhs = ""
  end

  return mode or { "n" }, lhs, rhs, map
end

--- Globally applies a list of key mappings.
---@param maps VoidMapping[] Mappings to set.
function M.set(maps)
  local length = #maps

  for i = 1, length do
    local mode, lhs, rhs, opts = prepare_mapping(maps[i])
    for _, m in ipairs(mode) do
      vim.api.nvim_set_keymap(m, lhs, rhs, opts)
    end
  end
end

--- Applies a list of key mappings to a specific buffer.
---@param maps VoidMapping[] Mappings to set.
function M.buf_set(bufnr, maps)
  local length = #maps

  for i = 1, length do
    local mode, lhs, rhs, opts = prepare_mapping(maps[i])
    for _, m in ipairs(mode) do
      vim.api.nvim_buf_set_keymap(bufnr, m, lhs, rhs, opts)
    end
  end
end

return M
