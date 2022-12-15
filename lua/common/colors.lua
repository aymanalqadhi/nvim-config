local M = {}

-- base color palette

---- Nord
-- M.palette = {
--   fg = "#E5E9F0",
--   bg = "#3B4252",
--   green = "#A3BE8C",
--   yellow = "#EBCB8B",
--   purple = "#B48EAD",
--   orange = "#D08770",
--   red = "#BF616A",
--   aqua = "#88C0D0",
--   cyan = "#A3C3E3",
--   blue = "#8FA3CE",
--   magenta = "#B48EAD",
--   darkblue = "#5E81AC",
--   dark_red = "#AE5059",
-- }

local tn_colors = require('tokyonight.colors').setup { style = 'night' }

M.palette = {
  bg = tn_colors.bg_statusline,
  fg = tn_colors.fg,
  yellow = tn_colors.yellow,
  cyan = tn_colors.cyan,
  darkblue = tn_colors.blue0,
  green = tn_colors.green,
  orange = tn_colors.orange,
  violet = tn_colors.purple,
  magenta = tn_colors.magenta,
  blue = tn_colors.blue,
  red = tn_colors.red,
  light_bg = tn_colors.bg_highlight,
  primary_blue = tn_colors.blue5,
}


-- get current mode color
function M.mode_color()
  local mode_colors = {
    NORMAL = M.palette.blue,
    OP = M.palette.blue,
    INSERT = M.palette.yellow,
    VISUAL = M.palette.magenta,
    LINES = M.palette.magenta,
    BLOCK = M.palette.magenta,
    REPLACE = M.palette.red,
    ['V-REPLACE'] = M.palette.red,
    ENTER = M.palette.cyan,
    MORE = M.palette.cyan,
    SELECT = M.palette.orange,
    COMMAND = M.palette.blue,
    SHELL = M.palette.green,
    TERM = M.palette.green,
    NONE = M.palette.green,
  }

  return mode_colors[require('common.util').mode_alias()]
end

return M
