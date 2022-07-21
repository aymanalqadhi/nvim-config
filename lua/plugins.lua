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

  -- snippets
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- language-specific lsp addons
  use 'simrat39/rust-tools.nvim'
  use 'saecki/crates.nvim'

  -- version control
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  -- productivity
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'
  use 'cohama/lexima.vim'

  -- syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }

  -- colorschems
  use 'adrian5/oceanic-next-vim'
  use 'kyazdani42/blue-moon'

  -- icons
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind-nvim'

  -- line
  use 'lukas-reineke/indent-blankline.nvim'

  -- indenation markers
  use 'nvim-lualine/lualine.nvim'

  -- startup page
  use 'mhinz/vim-startify'

  -- smoother scrolls
  use 'psliwka/vim-smoothie'

  -- telescope
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- typescript
  use 'jose-elias-alvarez/typescript.nvim'
  use 'windwp/nvim-ts-autotag'

-- move
use 'fedepujol/move.nvim'

  --- configure plugins ---
  require('pluginsconfig.indentblankline').configure()
  require('pluginsconfig.lualine').configure()
  require('pluginsconfig.lspconfig').configure()
  require('pluginsconfig.cmp').configure()
  require('pluginsconfig.crates').configure()
  require('pluginsconfig.telescope').configure()
  require('pluginsconfig.typescript').configure()
  require('pluginsconfig.nvimtsautotag').configure()
  require('rust-tools').setup({})

end)
