local M = {}

local use_theme = 'nordic'

if use_theme == 'nordic' then
  local colors = require('nordic.colors')

  M.none = colors.none

  -- background
  M.bg = colors.black
  M.bg_dark = colors.gray0
  M.bg_highlight = colors.gray2

  -- foreground
  M.fg = colors.white2
  M.fg_dark = colors.white0

  -- base colors
  M.red = colors.red.base
  M.green = colors.green.base
  M.blue = colors.blue0
  M.darkblue = colors.gray2
  M.primary_blue = colors.blue.bright

  -- extra colors
  M.yellow = colors.yellow.base
  M.cyan = colors.cyan.base
  M.orange = colors.orange.base
  M.violet = colors.magenta.dim
  M.magenta = colors.magenta.base

  -- compat
  M.border_nb = colors.border_nb

elseif use_theme == 'tokyonight' then
  local tn_colors = require('tokyonight.colors').setup { style = 'night' }

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
  M.primary_blue = tn_colors.blue5
end

-- mode colors
M.mode_colors = {
  NORMAL = M.primary_blue,
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
