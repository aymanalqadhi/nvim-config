local enable_autofmt = true

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
    {
      "<leader>ct",
      function()
        enable_autofmt = not enable_autofmt
      end,
      desc = "conform: toggle auto format",
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
    formatters = {
      stylua = {
        require_cwd = true,
      },
    },
  },

  config = function(_, opts)
    require("conform").setup(opts)

    void.event.on("BufWritePre", function(args)
      if enable_autofmt then
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
        })
      end
    end)
  end,
}
