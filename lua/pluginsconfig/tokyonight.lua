local tokyonight = require('tokyonight')

local function configure()
  tokyonight.setup {
    style = "night",
    transparent = false,
    terminal_colors = true,

    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "storm",
      floats = "night",
    },

    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = true,
    dim_inactive = true,
    lualine_bold = false,
  }

  -- colorscheme
  vim.cmd("colorscheme tokyonight")
end

return {
  configure = configure
}
