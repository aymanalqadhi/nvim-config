return require('packer').startup(function(use)
  -- self inclusion
  use 'wbthomason/packer.nvim'

  -- common
  use 'nvim-lua/plenary.nvim'

  -- optimaizations
  use 'lewis6991/impatient.nvim'

  -- language-specific lsp addons
  use 'simrat39/rust-tools.nvim'
  use 'saecki/crates.nvim'
  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'


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
  --
  --- configure plugins with configuration files ---
  require('pluginsconfig.crates').configure()
  require('pluginsconfig.dap').configure()
  require('pluginsconfig.dapui').configure()
  require('pluginsconfig.fluttertools').configure()
  require('pluginsconfig.rusttools').configure()


end)
