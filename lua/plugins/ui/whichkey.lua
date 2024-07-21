return {
  "folke/which-key.nvim",

  event = "VeryLazy",

  config = function()
    local wk = require("which-key")

    wk.setup({
      replace = {
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "➜",
        separator = "",
        group = "+",
      },
      win = {
        border = "none",
        padding = { 2, 2, 2, 2 },
        wo = {
          winblend = vim.o.winblend,
        },
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 40 },
        spacing = 4,
        align = "center",
      },
    })

    wk.add({
      { "<leader>d",      group = "+dap" },
      { "<leader>f",      group = "+find" },
      { "<leader>fg",     group = "+git" },
      { "<leader>g",      group = "+git" },
      { "<leader>l",      group = "+lsp" },
      { "<leader>t",      group = "+treesitter" },

      -- lang
      { "<localleader>r", group = "+rust" },
      { "<localleader>g", group = "+go" },
      { "<localleader>c", group = "+cpp" },

      -- editor
      { "<leader>b",      group = "+buffer" },
      { "<leader>w",      group = "+window" },
    })
  end,
}
