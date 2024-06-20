return {
  "navarasu/onedark.nvim",

  lazy = false,
  priority = 1000,

  opts = {
    style = "dark",
    transparent = true,
    term_colors = true,
    ending_tildes = true,

    code_style = {
      comments = "italic",
      keywords = "bold",
      functions = "none",
      strings = "none",
      variables = "none",
    },

    lualine = {
      transparent = false,
    },

    colors = {},
    highlights = {},

    diagnostics = {
      darker = true,
      undercurl = true,
      background = true,
    },
  },

  config = function(_, opts)
    require("onedark").setup(opts)
    require("onedark").load()

    vim.cmd([[
      hi! def  LspReferenceRead  cterm=bold gui=underline
      hi! def  LspReferenceWrite cterm=bold gui=underline
      hi! link LspReferenceText  CursorLine
    ]])
  end,
}
