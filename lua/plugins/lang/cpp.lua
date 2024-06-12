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

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype

          if ft == "c" or ft == "cpp" then
            Void.core.keymap.set({
              ["<localleader>c"] = {
                i = { "<cmd>ClangdToggleInlayHints<cr>", "c/cpp: toggle inlay hints" },
                h = { "<cmd>ClangdSwitchSourceHeader<cr>", "c/cpp: switch source/header" },
                H = { "<cmd>ClangdTypeHierarchy<cr>", "c/cpp: type hierarchy" },
                a = { "<cmd>ClangdAst<cr>", "c/cpp: show ast" },
                m = { "<cmd>ClangdMemoryUsage<cr>", "c/cpp: memory usage" },
              },
              opts = { buffer = args.bufnr },
            })
          end
        end
      })
    end,
  },
}
