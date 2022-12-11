local M = {}

-- gets current mode color
function M.mode_alias()
  local aliases = {
    ['n'] = 'NORMAL',
    ['no'] = 'OP',
    ['nov'] = 'OP',
    ['noV'] = 'OP',
    ['no'] = 'OP',
    ['niI'] = 'NORMAL',
    ['niR'] = 'NORMAL',
    ['niV'] = 'NORMAL',
    ['v'] = 'VISUAL',
    ['vs'] = 'VISUAL',
    ['V'] = 'LINES',
    ['Vs'] = 'LINES',
    [''] = 'BLOCK',
    ['s'] = 'BLOCK',
    ['s'] = 'SELECT',
    ['S'] = 'SELECT',
    [''] = 'BLOCK',
    ['i'] = 'INSERT',
    ['ic'] = 'INSERT',
    ['ix'] = 'INSERT',
    ['R'] = 'REPLACE',
    ['Rc'] = 'REPLACE',
    ['Rv'] = 'V-REPLACE',
    ['Rx'] = 'REPLACE',
    ['c'] = 'COMMAND',
    ['cv'] = 'COMMAND',
    ['ce'] = 'COMMAND',
    ['r'] = 'ENTER',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!'] = 'SHELL',
    ['t'] = 'TERM',
    ['nt'] = 'TERM',
    ['null'] = 'NONE',
  }

  return aliases[vim.fn.mode()]
end

-- gets current mode label
function M.mode_label()
  local labels = {
    NORMAL = '<|',
    OP = '<|',
    INSERT = '|>',
    VISUAL = '<>',
    LINES = '<>',
    BLOCK = '<>',
    REPLACE = '<>',
    ['V-REPLACE'] = '<>',
    ENTER = '<>',
    MORE = '<>',
    SELECT = '<>',
    COMMAND = '<|',
    SHELL = '<|',
    TERM = '<|',
    NONE = '<>',
    CONFIRM = '|>'
  }
  return labels[M.mode_alias()]
end

return M
