return {
  "stevearc/conform.nvim",

  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",

  opts = {
    lsp_fallback = true,
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },

  init = function()
    -- register formatter
    require("util").format.register({
      name = "conform.nvim",
      enabled = true,
      priority = 100,
      format = require("conform").format,
      formatexpr = function()
        return require("conform").formatexpr()
      end,
    })
  end,
}
