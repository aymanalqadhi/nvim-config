return require('packer').startup(function(use)
  -- self inclusion
  use 'wbthomason/packer.nvim'

  -- common
  use 'nvim-lua/plenary.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use('jose-elias-alvarez/null-ls.nvim')

  -- snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- language-specific lsp addons
  use 'simrat39/rust-tools.nvim'
  use 'saecki/crates.nvim'

  -- version control
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- productivity
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'
  use 'cohama/lexima.vim'
  use 'MunifTanjim/prettier.nvim'

  -- syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }

  -- colorschems
  use 'adrian5/oceanic-next-vim'
  use 'kyazdani42/blue-moon'
  use 'olimorris/onedarkpro.nvim'

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

  -- startup page
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- smoother scrolls
  use 'psliwka/vim-smoothie'

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
  require('pluginsconfig.indentblankline').configure()
  require('pluginsconfig.lspconfig').configure()
  require('pluginsconfig.cmp').configure()
  require('pluginsconfig.crates').configure()
  require('pluginsconfig.telescope').configure()
  require('pluginsconfig.typescript').configure()
  require('pluginsconfig.gitsigns').configure()
  require('pluginsconfig.nvimtsautotag').configure()
  require('pluginsconfig.alpha').configure()
  require('pluginsconfig.onedarkpro').configure()
  require('pluginsconfig.nullls').configure()
  require('pluginsconfig.prettier').configure()
  require('pluginsconfig.barbar').configure()

  --  manually configure plugins --
  require('rust-tools').setup{}
  require('trouble').setup{}
end)
