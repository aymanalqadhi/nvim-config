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

      -- autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'andersevenrud/cmp-tmux' },
      { 'hrsh7th/cmp-cmdline' },

      -- snippets
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- language-specific lsp addons
  use 'simrat39/rust-tools.nvim'
  use 'saecki/crates.nvim'
  use 'RRethy/vim-illuminate'
  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- lsp addons
  use 'folke/twilight.nvim'

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  -- productivity
  use 'tpope/vim-surround'
  use 'tpope/vim-eunuch'
  use 'ThePrimeagen/refactoring.nvim'
  use 'ggandor/leap.nvim'
  use 'windwp/nvim-autopairs'

  -- icons
  use 'onsails/lspkind-nvim'

  -- move
  use 'fedepujol/move.nvim'

  -- diagnostics list
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- ui
  use 'MunifTanjim/nui.nvim'
  use 'folke/noice.nvim'


  --- configure plugins with configuration files ---
  require('pluginsconfig.lspzero').configure()
  require('pluginsconfig.cmp').configure()
  require('pluginsconfig.nullls').configure()
  require('pluginsconfig.crates').configure()
  require('pluginsconfig.illuminate').configure()
  require('pluginsconfig.dap').configure()
  require('pluginsconfig.dapui').configure()
  require('pluginsconfig.fluttertools').configure()
  require('pluginsconfig.rusttools').configure()
  require('pluginsconfig.noice').configure()
  require('pluginsconfig.twilight').configure()

  -- manually configure plugins --
  require('trouble').setup()
  require('luasnip.loaders.from_vscode').lazy_load()
  require('leap').set_default_keymaps()
  require('nvim-autopairs').setup()

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
