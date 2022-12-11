local M = {}

-- base color palette
M.palette = {
  fg = "#E5E9F0",
  bg = "#3B4252",
  green = "#A3BE8C",
  yellow = "#EBCB8B",
  purple = "#B48EAD",
  orange = "#D08770",
  red = "#BF616A",
  aqua = "#88C0D0",
  cyan = "#A3C3E3",
  blue = "#8FA3CE",
  magenta = "#B48EAD",
  darkblue = "#5E81AC",
  dark_red = "#AE5059",
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
