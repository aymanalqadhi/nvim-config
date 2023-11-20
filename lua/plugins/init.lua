return {
  -- core
  core = {
    "treesitter", -- better highlighting
    "lsp", -- LSP support
    "none-ls", -- additional LSP support
  },

  -- editor addons
  editor = {
    "luasnip", -- snippets engine
    "cmp", -- completion engine
    "mini", -- useful utilities
    "flash", -- better search
    "illuminate", -- cursor word
    "persistence", -- session management
    "nvim-autopairs", -- smart character pairs matching
    "nvim-surround", -- text surround utils
    "tabout", -- tab completion
    -- "multicursors", -- multiple cursors
  },

  -- tooling integration
  tooling = {
    "telescope", -- fuzzy finder
    "conform", -- formatter
    "gitsigns", -- git integration
    "toggleterm", -- terminal integration
    "mason", -- external tools installation
  },

  -- language support
  lang = {
    "copilot",
    "docker",
    "go",
    "rust",
    "sql",
  },

  -- user interface
  ui = {
    "dashboard", -- startup screen
    "ibl", -- indent guide lines
    -- "dressing", -- better ui
    "bufferline", -- buffer bar
    "whichkey", -- keybindings popup
    "noice", -- better messages & popup menus.
    "notify", -- better `vim.notify()`
    "nvim-tree", -- file tree
    "lualine", -- status line
    "trouble", -- better lists
    "symbol-usage", -- lsp symbol counter
    -- "tint", -- tinting

    -- colorschemes
    "onedark",
    "tokyonight",
  },
}
