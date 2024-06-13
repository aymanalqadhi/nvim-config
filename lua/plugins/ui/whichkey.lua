return {
  "folke/which-key.nvim",

  event = "VeryLazy",

  opts = {
    key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "➜",
      separator = "",
      group = "+",
    },
    window = {
      border = "none",
      margin = { 0, 3, 3, 3 },
      padding = { 2, 2, 2, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 40 },
      spacing = 4,
      align = "center",
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  },

  config = function(_, opts)
    local wk = require("which-key")

    wk.setup(opts)
    wk.register({
      ["<leader>d"] = { name = "+dap" },
      ["<leader>f"] = { name = "+find" },
      ["<leader>fg"] = { name = "+git" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>t"] = { name = "+treesitter" },

      -- lang
      [",r"] = { name = "+rust" },
      [",g"] = { name = "+go" },
      [",c"] = { name = "+cpp" },
    })
  end,
}
