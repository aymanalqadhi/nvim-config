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
      functions = {},
      variables = {},
      sidebars = 'dark',
      floats = 'dark',
    },
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,

  })

  vim.cmd [[ colorscheme tokyonight ]]
end

return M
