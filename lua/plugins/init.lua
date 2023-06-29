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
        branch = plugin.branch,
        priority = plugin.priority,
        dependencies = plugin.dependencies,
        config =
            plugin.set_keymaps and
            function()
              if plugin.configure ~= nil then
                plugin.configure()
              end

              plugin.set_keymaps(require('which-key'))
            end
            or plugin.configure,
        lazy = plugin.lazy,
        keys = plugin.load_on_keys,
        event = plugin.load_on_event,
        cmd = plugin.load_on_cmd,
        ft = plugin.filetypes,
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
