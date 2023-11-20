return {
  "nvimtools/none-ls.nvim",

  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "mason.nvim" },

  opts = function(_, opts)
    local nls = require("null-ls")

    opts.root_dir = opts.root_dir
      or require("null-ls.utils").root_pattern(
        ".null-ls-root",
        ".neoconf.json",
        "Cargo.toml",
        "go.pkg",
        "CMakeLists.txt",
        "Makefile",
        ".git"
      )

    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.fish,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.shfmt,
    })
  end,

  init = function()
    -- register formatter
    require("util").event.on("VeryLazy", function()
      require("util").format.register({
        name = "none-ls.nvim",
        priority = 200,
        format = function(opts)
          opts = vim.tbl_extend("force", opts or {}, {
            filter = function(client)
              return client.name == "null-ls"
            end,
          })
        end,
        formatexpr = function()
          return vim.lsp.buf.formatexpr({})
        end,
      })
    end)
  end,
}
