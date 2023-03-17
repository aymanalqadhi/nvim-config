local M = {}

-- plugin uri
M.uri = 'folke/tokyonight.nvim'

-- plugin configuration function
function M.configure()
  require('tokyonight').setup({
    style = 'night',
    light_style = 'day',
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = { italic = true },
      variables = {},
      sidebars = 'dark',
      floats = 'normal',
    },
    sidebars = { "qf", "help", "vista_kind", "terminal", "packer" },
    day_brightness = 0.3,
    hide_inactive_statusline = true,
    dim_inactive = false,
    lualine_bold = false,
  })

  vim.cmd [[ colorscheme tokyonight ]]
end

return M
