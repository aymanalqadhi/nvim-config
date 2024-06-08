return {
  "navarasu/onedark.nvim",

  lazy = false,
  priority = 1000,

  dependencies = {
    {
      "rachartier/tiny-devicons-auto-colors.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },

      config = function()
      end
    },
  },

  opts = {
    style = "dark",
    transparent = true,
    term_colors = true,
    ending_tildes = true,

    code_style = {
      comments = "italic",
      keywords = "bold",
      functions = "none",
      strings = "none",
      variables = "none",
    },

    lualine = {
      transparent = false,
    },

    colors = {},
    highlights = {},

    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  },

  config = function(_, opts)
    require("onedark").setup(opts)
    require("onedark").load()

    require('tiny-devicons-auto-colors').setup({
      colors = require("onedark.palette").dark,
    })
  end,
}
