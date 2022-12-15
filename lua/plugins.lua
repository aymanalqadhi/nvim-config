return require('packer').startup(function(use)
  -- self inclusion
  use 'wbthomason/packer.nvim'

  local plugins = require('plugins.init')

  for _, plugin_name in ipairs(plugins) do
    local loaded, plugin = pcall(require, 'plugins.' .. plugin_name)

    if not loaded then
      print('Could not load plugin: ' .. plugin_name)
    else
      use({
        plugin.uri,
        requires = plugin.requirements,
        config = plugin.configure
      })

      if plugin.keymaps then
        require('which-key').register(plugin.keymaps())
      end
    end
  end

end)
