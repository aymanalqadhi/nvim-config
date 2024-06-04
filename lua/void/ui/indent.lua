return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",

  event = { "BufRead", "BufNewFile" },

  opts = {
    indent = {
      char = "│",
    },
    scope = {
      show_start = false,
      include = {
        node_type = { lua = { "return_statement", "table_constructor" } },
      },
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "NvimTree",
      },
    },
  },
}
