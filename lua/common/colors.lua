local M = {}

local tn_colors = require('tokyonight.colors').setup { style = 'night' }

-- colors palette
M.none = tn_colors.none
M.bg = tn_colors.bg
M.bg_dark = tn_colors.bg_dark
M.bg_highlight = tn_colors.bg_highlight
M.fg = tn_colors.fg
M.fg_dark = tn_colors.fg_dark
M.yellow = tn_colors.yellow
M.cyan = tn_colors.cyan
M.green = tn_colors.green
M.orange = tn_colors.orange
M.violet = tn_colors.purple
M.magenta = tn_colors.magenta
M.blue = tn_colors.blue
M.darkblue = tn_colors.blue0
M.red = tn_colors.red
M.light_bg = tn_colors.bg_highlight
M.primary_blue = tn_colors.blue5

-- mode colors
M.mode_colors = {
  NORMAL = M.blue,
  OP = M.darkblue,
  INSERT = M.yellow,
  VISUAL = M.magenta,
  LINES = M.magenta,
  BLOCK = M.magenta,
  REPLACE = M.red,
  ['V-REPLACE'] = M.red,
  ENTER = M.cyan,
  MORE = M.cyan,
  SELECT = M.orange,
  COMMAND = M.green,
  SHELL = M.green,
  TERM = M.green,
  NONE = M.green,
}

-- get current mode color
function M.mode_color()
  return M.mode_colors[require('common.util').mode_alias()]
end

return M
