---Core keymaps management module
---@class void.core.keymap
local M = {}

---Default keymaps options
---@class VoidMappingOpts
---@field buffer  number|nil   # Buffer identifier on which to apply keymaps.
---@field silent  boolean      # Whether or not the mapping should be silent.
---@field noremap boolean      # Whether or not the mapping should be recursive.
M.default_opts = {
  buffer  = nil,
  silent  = true,
  noremap = true,
}

function M._register(mapping)
  assert(type(mapping) == "table", "mappings should be a table")

  local opts = mapping.opts
  local mode = mapping.mode
  local prefix = mapping.prefix

  mapping.opts = nil
  mapping.prefix = nil
  mapping.mode = nil

  if type(mapping[1]) == "string" or type(mapping[1]) == "function" then
    opts.desc = mapping[2] or opts.desc
    vim.keymap.set(mode or "n", prefix, mapping[1], opts)
  else
    for key, inner in pairs(mapping) do
      if type(inner) == "string" then
        M._register({
          inner,
          prefix = prefix .. key,
          mode = mode,
          opts = opts,
        })
      else
        inner.prefix = prefix .. (inner.prefix or "") .. (type(key) == "string" and key or "")
        inner.mode = inner.mode or mode
        inner.opts = vim.tbl_extend("force", opts, inner.opts or {})

        M._register(inner)
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
function M.register(m)
  if vim.islist(m) then
    for _, mapping in m do
      M.register(mapping)
    end
  else
    m.prefix = m.prefix or ""
    m.mode   = m.mode or "n"
    m.opts   = vim.tbl_extend("force", M.default_opts, m.opts or {})

    M._register(m)
  end
end

return M
