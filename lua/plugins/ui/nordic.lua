return {
  "AlexvZyl/nordic.nvim",

  -- branch = "dev",
  priority = 1000,
  lazy = false,

  opts = function()
    local colors = require("nordic.colors")

    return {
      bold_keyword = true,
      transparent_bg = true,
      reduced_blue = false,

      cursorline = {
        theme = "light",
      },

      override = {
        -- fold column
        FoldColumn = { bg = colors.none, fg = colors.fg_fold },

        -- illuminate highlights
        illuminatedWord = { bg = colors.gray1 },
        illuminatedCurWord = { underline = true, bg = colors.gray1 },
        illuminatedWordText = { underline = true, bg = colors.gray1 },
        illuminatedWordRead = { bg = colors.gray2 },
        illuminatedWordWrite = { bg = colors.gray2 },

        -- cmp
        PmenuSel = { bg = colors.gray2 },

        -- lighter markers
        CursorLine = { bg = colors.black1 },
        CursorColumn = { bg = colors.black1 },
        ColorColumn = { bg = colors.gray0 },
        Visual = { bg = colors.gray2 },
      },
    }
  end,

  config = function(_, opts)
    require("nordic").setup(opts)

    vim.cmd.colorscheme("nordic")
  end,

  cond = function()
    local cfg = require("config").current
    return cfg and cfg.colorscheme == "nordic"
  end,
}
