local function merge_plugins(mods)
  local ret = {}

  for _, mod in ipairs(mods) do
    local submods = require('plugins.' .. mod)

    for _, submod in ipairs(submods) do
      table.insert(ret, mod .. '.' .. submod)
    end
  end

  return ret
end

return merge_plugins({
  'core',
  'ui',
  'misc',
  'lsp',
  'scm',
})
