local one_dark_pro = require('onedarkpro')

local function configure()
  one_dark_pro.setup {
    dark_theme = "onedark", -- The default dark theme
    light_theme = "onelight", -- The default light theme
    plugins = {
        all = true
    },
    styles = { -- Choose from "bold,italic,underline"
      comments = "italic",
      functions = "NONE",
      keywords = "bold,italic",
      strings = "NONE",
      variables = "NONE",
      virtual_text = "NONE"
    },
    options = {
        bold = true, -- Use the themes opinionated bold styles?
        italic = true, -- Use the themes opinionated italic styles?
        underline = true, -- Use the themes opinionated underline styles?
        undercurl = true, -- Use the themes opinionated undercurl styles?
        cursorline = true, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
    }
  }

end

return {
  configure = configure
}
