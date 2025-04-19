return {
  "mfussenegger/nvim-lint",

  dependencies = { "williamboman/mason.nvim" },

  event = { "BufWritePre" },

  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      lua = { "selene" },
    }

    void.event.on("BufWritePost", function()
      lint.try_lint()
    end)
  end,
}
