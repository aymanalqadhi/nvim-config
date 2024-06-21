return {
  {
    "p00f/clangd_extensions.nvim",

    dependencies = { "neovim/nvim-lspconfig" },

    ft = { "c", "cpp" },

    opts = {
      memory_usage = { border = "none" },
      symbol_info = { border = "none" },
    },

    config = function(_, opts)
      require("clangd_extensions").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern  = { "c", "cpp" },
        group    = vim.api.nvim_create_augroup("void-cpp", { clear = true }),
        callback = function(args)
          Void.keymap.buf_set(args.buf, {
            { "<localleader>ch", "<cmd>ClangdToggleInlayHints<cr>",   desc = "c/cpp: toggle inlay hints" },
            { "<localleader>cs", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "c/cpp: switch source/header" },
            { "<localleader>ct", "<cmd>ClangdTypeHierarchy<cr>",      desc = "c/cpp: type hierarchy" },
            { "<localleader>ca", "<cmd>ClangdAst<cr>",                desc = "c/cpp: show ast" },
            { "<localleader>cm", "<cmd>ClangdMemoryUsage<cr>",        desc = "c/cpp: memory usage" },
          })
        end
      })
    end,
  },
}
