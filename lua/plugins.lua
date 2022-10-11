return require('packer').startup(function(use)
  -- self inclusion
  use 'wbthomason/packer.nvim'

  -- common
  use 'nvim-lua/plenary.nvim'

  -- lsp
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- lsp support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },

      -- autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-calc' },
      { 'dmitmel/cmp-cmdline-history' },
      { 'ray-x/cmp-treesitter' },
      { 'ray-x/lsp_signature.nvim' },

      -- snippets
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },

      -- status
      { 'j-hui/fidget.nvim' },
    }
  }

  -- language-specific lsp addons
  use 'simrat39/rust-tools.nvim'
  use 'saecki/crates.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'RRethy/vim-illuminate'
  use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- source control
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'

  -- productivity
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'
  use 'cohama/lexima.vim'
  use 'MunifTanjim/prettier.nvim'
  use 'rmagatti/goto-preview'
  use 'wfxr/minimap.vim'
  use 'akinsho/toggleterm.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'ThePrimeagen/refactoring.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'ggandor/leap.nvim'

  -- better syntax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'folke/todo-comments.nvim'

  -- colorschems
  use 'adrian5/oceanic-next-vim'
  use 'kyazdani42/blue-moon'
  use 'olimorris/onedarkpro.nvim'
  use 'folke/tokyonight.nvim'

  -- icons
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind-nvim'

  -- indenation markers
  use 'lukas-reineke/indent-blankline.nvim'

  -- line
  use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
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
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'

  -- typescript
  use 'jose-elias-alvarez/typescript.nvim'
  use 'windwp/nvim-ts-autotag'

  -- move
  use 'fedepujol/move.nvim'

  -- hover
  use 'lewis6991/hover.nvim'

  -- diagnostics list
  use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- folding
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  use { 'anuvyklack/fold-preview.nvim', requires = 'anuvyklack/keymap-amend.nvim' }

  -- tmux integration
  use 'aserowy/tmux.nvim'

  -- scrolling
  use 'karb94/neoscroll.nvim'

  --- configure plugins with configuration files ---
  require('pluginsconfig.tmux').configure()
  require('pluginsconfig.lspzero').configure()
  require('pluginsconfig.cmp').configure()
  require('pluginsconfig.treesitter').configure()
  require('pluginsconfig.nullls').configure()
  require('pluginsconfig.lspsignature').configure()
  require('pluginsconfig.emmetls').configure()
  require('pluginsconfig.crates').configure()
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
  require('pluginsconfig.toggleterm').configure()
  require('pluginsconfig.nvimtree').configure()
  require('pluginsconfig.tokyonight').configure()
  require('pluginsconfig.telescope').configure()
  require('pluginsconfig.dap').configure()
  require('pluginsconfig.dapui').configure()
  require('pluginsconfig.ufo').configure()
  require('pluginsconfig.fluttertools').configure()
  require('pluginsconfig.rusttools').configure()

  -- manually configure plugins --
  require('trouble').setup {}
  require('fidget').setup {}
  require('luasnip.loaders.from_vscode').lazy_load()
  require('symbols-outline').setup()
  require('fold-preview').setup()
  require('neoscroll').setup()
  require('treesitter-context').setup()
  require("todo-comments").setup()
  require('leap').set_default_keymaps()

end)
