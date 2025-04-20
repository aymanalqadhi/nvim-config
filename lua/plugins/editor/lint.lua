return {
  "mfussenegger/nvim-lint",

  dependencies = { "williamboman/mason.nvim" },

  event = { "BufWritePre" },

  config = function()
    local lint = require("lint")

    -- override args
    lint.linters.sqlfluff.args = { "lint", "--format=json" }

    local linters_by_ft = {
      lua = {
        {
          "selene",
          cwd = function(args)
            return vim.fs.root(args.file, "selene.toml")
          end,
          require_cwd = false,
        },
      },
      sql = {
        {
          "sqlfluff",
          cwd = function(args)
            return vim.fs.root(args.file, { ".sqlfluff" })
          end,
          require_cwd = true,
        },
      },
    }

    void.event.on({ "BufEnter", "BufWritePost" }, function(args)
      local ft = vim.bo[args.buf].filetype
      local linters = linters_by_ft[ft]

      if not linters or #linters == 0 then
        return
      end

      for _, linter in ipairs(linters) do
        local cwd = linter.cwd and linter.cwd(args)
        if cwd or not linter.require_cwd then
          require("lint").try_lint(linter[1], { cwd = cwd })
        end
      end
    end)
  end,
}
