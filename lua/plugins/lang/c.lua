return {
  {
    "p00f/clangd_extensions.nvim",

    ft = { "c", "cpp" },

    opts = {
      inlay_hints = {
        inline = false,
      },
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
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",

    opts = {
      ensure_install = { "c", "cpp" },
    },
  },
}
