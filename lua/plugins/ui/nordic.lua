local M = {}

-- plugin uri
M.uri = 'AlexvZyl/nordic.nvim'
M.branch = 'dev'

-- plugin configuration function
function M.configure()
  local colors = require('nordic.colors')
  colors.extend_palette()

  local active_bg = colors.grey2
  local inactive_bg = colors.gray1

  require('nordic').setup {
    -- available: 'nordic', 'onedark'.
    theme = 'nordic',

    -- theme options
    bold_keywords = true,
    italic_comments = true,
    transparent_bg = false,
    bright_border = false,
    swap_backgrounds = false,

    -- theme variant options
    nordic = { reduced_blue = false },
    onedark = { brighter_whites = true },

    -- cursorline options
    cursorline = {
      bold = false,
      theme = 'light',
      hide_unfocused = true,
      blend = 0.4,
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
      FoldColumn = { bg = colors.bg, fg = colors.fg_fold },

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

      -- barbar
      ---- visible
      BufferVisible = { bg = inactive_bg, fg = colors.white0 },
      BufferVisibleADDED = { bg = inactive_bg, fg = colors.git.add },
      BufferVisibleCHANGED = { bg = inactive_bg, fg = colors.git.change },
      BufferVisibleDELETED = { bg = inactive_bg, fg = colors.git.delete },
      BufferVisibleHINT = { bg = inactive_bg, fg = colors.hint },
      BufferVisibleINFO = { bg = inactive_bg, fg = colors.info },
      BufferVisibleWARN = { bg = inactive_bg, fg = colors.warning },
      BufferVisibleERROR = { bg = inactive_bg, fg = colors.error },
      BufferVisibleMod = { bg = inactive_bg, fg = colors.fg },
      BufferVisibleTarget = { bg = inactive_bg, fg = colors.fg_bright, bold = true },
      BufferVisibleSign = { fg = inactive_bg, bg = colors.bg_dark },
      ---- active
      BufferCurrent = { bg = active_bg, fg = colors.fg },
      BufferCurrentADDED = { bg = active_bg, fg = colors.git.add },
      BufferCurrentCHANGED = { bg = active_bg, fg = colors.git.change },
      BufferCurrentDELETED = { bg = active_bg, fg = colors.git.delete },
      BufferCurrentHINT = { bg = active_bg, fg = colors.hint },
      BufferCurrentINFO = { bg = active_bg, fg = colors.info },
      BufferCurrentWARN = { bg = active_bg, fg = colors.warning },
      BufferCurrentERROR = { bg = active_bg, fg = colors.error },
      BufferCurrentMod = { bg = active_bg, fg = colors.fg_bright, bold = true },
      BufferCurrentTarget = { bg = active_bg, fg = colors.orange.base },
      BufferCurrentSign = { fg = active_bg, bg = colors.bg_dark },
      ---- inactive 
      BufferInactiveSign = { bg = colors.bg_dark, fg = colors.bg_dark },
      BufferInactiveTarget = { bg = colors.bg_dark, fg = colors.orange.bright },
    }
  }

  --require('nordic').load()
  vim.cmd.colorscheme 'nordic'
end

return M
