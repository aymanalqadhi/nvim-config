--- @brief merges plugin groups
--- @param mods table Plugin groups to be merged
--- @return table ret Merged groups table
local function merge_plugins(mods)
  local ret = {}

  for _, mod in ipairs(mods) do
    local submods = require('plugins.' .. mod)

    for _, submod in ipairs(submods) do
      local plugin_path = 'plugins.' .. mod .. '.' .. submod
      local loaded, plugin = pcall(require, plugin_path)

      assert(loaded, "could not load plugin at `" .. plugin_path .. "`")

      table.insert(ret, {
        plugin.uri,
        dependencies = plugin.dependencies,
        config = plugin.configure
      })
    end
  end

  return ret
end

-- return merged plugin groups
return merge_plugins({
  'core',
  'ui',
  'misc',
  'lsp',
  'prod',
  'scm',
  'langtools',
  'dap',
})
