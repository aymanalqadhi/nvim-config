return require('packer').startup(function(use)
  -- self inclusion
  use 'wbthomason/packer.nvim'

  -- common
  use 'nvim-lua/plenary.nvim'

  -- lsp
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'jose-elias-alvarez/null-ls.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},

      -- status
      {'j-hui/fidget.nvim'},
    }
  }

  -- snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- language-specific lsp addons
  use 'simrat39/rust-tools.nvim'
  use 'saecki/crates.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'RRethy/vim-illuminate'

  -- version control
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- productivity
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'
  use 'cohama/lexima.vim'
  use 'MunifTanjim/prettier.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'rmagatti/goto-preview'

  -- syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }

  -- colorschems
  use 'adrian5/oceanic-next-vim'
  use 'kyazdani42/blue-moon'
  use 'olimorris/onedarkpro.nvim'
  use 'tiagovla/tokyodark.nvim'

  -- icons
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind-nvim'

  -- indenation markers
  use 'lukas-reineke/indent-blankline.nvim'

  -- line
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use 'feline-nvim/feline.nvim'
  use 'SmiteshP/nvim-gps'

  -- startup page
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- typescript
  use 'jose-elias-alvarez/typescript.nvim'
  use 'windwp/nvim-ts-autotag'

  -- move
  use 'fedepujol/move.nvim'

  -- hover
  use 'lewis6991/hover.nvim'

  -- diagnostics list
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  --- configure plugins with configuration files ---
  require('pluginsconfig.lspzero').configure()
  require('pluginsconfig.cmp').configure()
  require('pluginsconfig.nullls').configure()
  require('pluginsconfig.crates').configure()
  require('pluginsconfig.telescope').configure()
  require('pluginsconfig.typescript').configure()
  require('pluginsconfig.gitsigns').configure()
  require('pluginsconfig.nvimtsautotag').configure()
  require('pluginsconfig.alpha').configure()
  require('pluginsconfig.onedarkpro').configure()
  require('pluginsconfig.prettier').configure()
  require('pluginsconfig.barbar').configure()
  require('pluginsconfig.feline').configure()
  require('pluginsconfig.indentblankline').configure()
  require('pluginsconfig.illuminate').configure()
  require('pluginsconfig.gotopreview').configure()

  --  manually configure plugins --
  require('rust-tools').setup{}
  require('trouble').setup{}
  require('nvim-tree').setup()
  require('fidget').setup{}

end)
