return {
  {
    "p00f/clangd_extensions.nvim",

    dependencies = { "neovim/nvim-lspconfig" },

    ft = { "c", "cpp" },
    keys = {
      { ",ci", "<cmd>ClangdToggleInlayHints<cr>",   desc = "c/cpp: toggle inlay hints" },
      { ",cH", "<cmd>ClangdTypeHierarchy<cr>",      desc = "c/cpp: type hierarchy" },
      { ",ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "c/cpp: switch source/header" },
      { ",ca", "<cmd>ClangdAst<cr>",                desc = "c/cpp: show ast" },
      { ",cm", "<cmd>ClangdMemoryUsage<cr>",        desc = "c/cpp: memory usage" },
    },

    opts = {
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
        highlights = {
          detail = "Comment",
        },
      },
      memory_usage = {
        border = "none",
      },
      symbol_info = {
        border = "none",
      },
    },

    config = function(_, opts)
      require("clangd_extensions").setup(opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype

          if ft == "c" or ft == "cpp" then
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
          end
        end
      })
    end,
  },
}
