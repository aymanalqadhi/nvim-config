local M = {}

-- plugin uri
M.uri = 'AlexvZyl/nordic.nvim'

-- plugin configuration function
function M.configure()
  require 'nordic'.setup {
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
      DiagnosticUnderlineError = { undercurl = true },
      DiagnosticUnderlineWarn = { undercurl = true },
      DiagnosticUnderlineInfo = { underdashed = true },
      DiagnosticUnderlineHint = { underdotted = true },
    }
  }

  vim.cmd [[ colorscheme nordic ]]
end

return M
