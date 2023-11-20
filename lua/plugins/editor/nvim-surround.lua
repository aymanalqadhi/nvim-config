return {
  "kylechui/nvim-surround",

  version = "*",
  event = "VeryLazy",
  opts = {
    highlight = {
      duration = 200,
    },
  },

  keys = {
    -- normal mode
    { "ys", desc = "Surround" },
    { "yss", desc = "Surround (current)" },
    { "yS", desc = "Surround (line)" },
    { "ySS", desc = "Surround (crruent line)" },
    { "ds", desc = "Delete Surround" },
    { "cs", desc = "Change Surround" },

    -- normal mode
    { "S", desc = "Surround", mode = { "v" } },
    { "gS", desc = "Surround (line)", mode = { "v" } },

    -- insert mode
    { "<C-g>s", desc = "Surround", mode = { "i" } },
  },
}
