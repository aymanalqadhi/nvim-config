return {
  {
    "folke/lazydev.nvim",

    dependencies = { "hrsh7th/nvim-cmp" },

    ft = "lua",

    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },
}
