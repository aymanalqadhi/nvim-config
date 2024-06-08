---Core keymaps management module
---@class void.core.keymap
local M = {}

---Default keymaps options
---@class VoidMappingOpts
---@field buffer  number|nil   # Buffer identifier on which to apply keymaps.
---@field silent  boolean      # Whether or not the mapping should be silent.
---@field noremap boolean      # Whether or not the mapping should be recursive.
M.default_opts = {
  silent = true,
}

function M._set(prefix, mapping)
  assert(type(mapping) == "table", "mappings should be a table")

  local opts = mapping.opts
  local mode = mapping.mode

  mapping.opts = nil
  mapping.mode = nil

  if type(mapping[1]) == "string" or type(mapping[1]) == "function" then
    opts.desc = mapping[2] or opts.desc
    vim.keymap.set(mode or "n", prefix, mapping[1], opts)
  else
    for key, inner in pairs(mapping) do
      if type(inner) == "string" then
        M._set(prefix .. key, { inner, mode = mode, opts = opts })
      else
        inner.mode = inner.mode or mode
        inner.opts = opts and vim.tbl_extend("keep", inner.opts or {}, opts) or inner.opts

        M._set(prefix .. (type(key) == "string" and key or ""), inner)
      end
    end
  end
end

---@class VoidMapping
---@field mode   string|table|nil # The mode(s) the mapping should apply to.
---@field prefix string|nil       # The key combination required to invoke the mapping.
---@field opts   table|nil        # Options to pass to `vim.keymap.set`.

---Applies a key mapping.
---@param m VoidMapping|VoidMapping[] Mapping(s) to set.
function M.set(m)
  if vim.islist(m) then
    for _, mapping in m do
      M.set(mapping)
    end
  else
    m.mode = m.mode or "n"
    m.opts = vim.tbl_extend("force", M.default_opts, m.opts or {})

    M._set("", m)
  end
end

return M
