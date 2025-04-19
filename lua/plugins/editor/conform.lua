return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
        })
      end,
      desc = "conform: format",
    },
  },

  opts = {
    formatters_by_ft = {
      cmake = { "cmake_format" },
      javascript = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      sql = { "sqlfluff" },
      typescript = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier", "yamlfmt" },
    },
  },

  config = function(_, opts)
    require("conform").setup(opts)

    void.event.on("BufWritePre", function(args)
      require("conform").format({
        bufnr = args.buf,
        lsp_fallback = true,
      })
    end)
  end,
}
