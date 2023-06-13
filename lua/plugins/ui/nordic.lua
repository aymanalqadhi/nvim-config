local M = {}

-- plugin uri
M.uri = 'AlexvZyl/nordic.nvim'

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
    bright_border = true,

    -- theme variant options
    nordic = { reduced_blue = true },
    onedark = { brighter_whites = true },

    -- cursorline options
    cursorline = {
      bold = false,
      theme = 'light',
      hide_unfocused = true,
    },

    -- plugin specific options
    noice = { style = 'classic' },
    telescope = { style = 'classic' },
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
    }
  }

  vim.cmd [[ colorscheme nordic ]]
end

return M
