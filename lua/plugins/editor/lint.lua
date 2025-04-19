return {
  "mfussenegger/nvim-lint",

  dependencies = { "williamboman/mason.nvim" },

  event = { "BufReadPost", "BufNewFile", "BufWritePre" },

  config = function()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
