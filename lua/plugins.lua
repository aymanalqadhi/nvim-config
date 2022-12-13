return require('packer').startup(function(use)
  -- self inclusion
  use 'wbthomason/packer.nvim'

  -- common
  use 'nvim-lua/plenary.nvim'

  -- optimaizations
  use 'lewis6991/impatient.nvim'

  -- lsp
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- lsp support
      { 'neovim/nvim-lspconfig' },
      { 'jose-elias-alvarez/null-ls.nvim' },
    }
  }

  -- language-specific lsp addons
  use 'simrat39/rust-tools.nvim'
  use 'saecki/crates.nvim'
  use 'RRethy/vim-illuminate'
  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  -- icons
  use 'onsails/lspkind-nvim'

  -- diagnostics list
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- ui
  use 'MunifTanjim/nui.nvim'
  use 'folke/noice.nvim'


  --- configure plugins with configuration files ---
  require('pluginsconfig.lspzero').configure()
  require('pluginsconfig.nullls').configure()
  require('pluginsconfig.crates').configure()
  require('pluginsconfig.illuminate').configure()
  require('pluginsconfig.dap').configure()
  require('pluginsconfig.dapui').configure()
  require('pluginsconfig.fluttertools').configure()
  require('pluginsconfig.rusttools').configure()
  require('pluginsconfig.noice').configure()

  -- manually configure plugins --
  require('trouble').setup()

  local plugins = require('plugins.init')

  for _, plugin_name in ipairs(plugins) do
    local loaded, plugin = pcall(require, 'plugins.' .. plugin_name)

    if not loaded then
      print('Could not load plugin: ' .. plugin_name)
    else
      use({
        plugin.uri,
        requires = plugin.requires,
        config = plugin.configure
      })

      if plugin.keymaps then
        require('which-key').register(plugin.keymaps())
      end
    end
  end

end)
