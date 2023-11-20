return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,

  opts = {
    style = "night",
    transparent = false,
    styles = {
      sidebars = "storm",
    },
  },

  config = function(_, opts)
    require("tokyonight").setup(opts)

    vim.cmd.colorscheme("tokyonight")
  end,

  cond = function()
    return require("config").current.colorscheme == "tokyonight"
  end,
}
