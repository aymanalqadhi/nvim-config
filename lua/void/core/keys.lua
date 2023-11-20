---Core keymaps management module.
---@class void.core.keys
local M = {}

---Default keymaps options
---@class VoidMappingOpts
---@field silent           boolean # Whether or not the mapping should be silent.
---@field noremap          boolean # Whether or not the mapping should be recursive.
---@field replace_keycodes boolean # Whether or not the mapping should replace keycodes.
M.default_opts = {
  silent = true,
  remap = false,
  replace_keycodes = false,
}

function M._register(mapping)
  assert(type(mapping) == "table", "mappings should be a table")

  local opts = mapping.opts
  local prefix = mapping.prefix
  local mode = mapping.mode

  mapping.opts = nil
  mapping.prefix = nil
  mapping.mode = nil

  if type(mapping[1]) == "string" then
    opts.desc = mapping[2]
    vim.keymap.set(mode, prefix, mapping[1], opts)
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
        inner.opts = inner.opts and vim.tbl_extend("force", opts, inner.opts) or vim.deepcopy(opts)

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
---@param m VoidMapping Mapping to set.
function M.register(m)
  m.prefix = m.prefix or ""
  m.mode = m.mode or "n"
  m.opts = m.opts and vim.tbl_extend("force", M.default_opts, m.opts) or M.default_opts

  M._register(m)
end

---Applies a list of key mappings.
---@param mappings VoidMapping[] List of mappings to set.
function M.register_many(mappings)
  assert(vim.tbl_islist(mappings))

  for _, key in ipairs(mappings) do
    M.register(key)
  end
end

return M
