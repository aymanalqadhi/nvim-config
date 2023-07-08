local M = {}

-- plugin uri
M.uri = 'AlexvZyl/nordic.nvim'
M.branch = 'dev'

-- plugin configuration function
function M.configure()
  local colors = require('nordic.colors')

  require('nordic').setup {
    -- available: 'nordic', 'onedark'.
    theme = 'nordic',

    -- theme options
    bold_keywords = true,
    italic_comments = true,
    transparent_bg = false,
    bright_border = false,

    -- theme variant options
    nordic = { reduced_blue = false },
    onedark = { brighter_whites = true },

    -- cursorline options
    cursorline = {
      bold = false,
      theme = 'light',
      hide_unfocused = true,
    },

    -- plugin specific options
    noice = { style = 'flat' },
    telescope = { style = 'flat' },
    leap = { dim_backdrop = true },

    -- overrides
    override = {
      -- dianostic highlights
      DiagnosticUnderlineError = { undercurl = true },
      DiagnosticUnderlineWarn = { undercurl = true },
      DiagnosticUnderlineInfo = { underdashed = true },
      DiagnosticUnderlineHint = { underdotted = true },

      -- illuminate highlights
      illuminatedWord = { bg = colors.gray1 },
      illuminatedCurWord = { underline = true, bg = colors.gray1 },
      illuminatedWordText = { underline = true, bg = colors.gray1 },
      illuminatedWordRead = { bg = colors.gray2 },
      illuminatedWordWrite = { bg = colors.gray2 },

      -- fold column
      FoldColumn = { bg = colors.bg, fg = colors.fg },

      -- winbar
      WinBar = { bg = colors.bg, fg = colors.fg },
      WinBarNC = { bg = colors.bg, fg = colors.fg },

      -- cmp
      CmpCompletionNormal = { bg = colors.gray1, fg = colors.fg },
      CmpCompletionBorder = { bg = colors.gray1, fg = colors.orange.base },
      CmpDocNormal = { bg = colors.bg_highlight, fg = colors.fg },
      CmpDocBorder = { bg = colors.bg_highlight, fg = colors.border_float_fg },
      PmenuSel = { bg = colors.fg, fg = colors.bg, bold = true },

      -- floats
      FloatBorder = { fg = colors.orange.base },

      -- noice
      NoiceNormal = { bg = colors.bg_dark, fg = colors.fg },
      NoiceFloatNormal = { bg = colors.bg_dark, fg = colors.fg },
      NoiceFloatBorder = { bg = colors.bg_dark, fg = colors.orange.base },
    }
  }

  vim.cmd [[ colorscheme nordic ]]
end

return M
