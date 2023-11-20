local M = {}

-- miscellaneous
M.misc = {
  dots = "󰇘",
  branch = "",
  record = "󰑋",
  engine = "",
  search = "",
  question = "",
}

-- file states
M.file = {
  modified = "",
  readonly = "",
  unnamed = " 󰍛",
  newfile = "",
}

-- debugging
M.dap = {
  Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint          = " ",
  BreakpointCondition = " ",
  BreakpointRejected  = { " ", "DiagnosticError" },
  LogPoint            = ".>",
}

-- lsp diagnostics
M.diagnostics = {
  Error = " ",
  Warn  = " ",
  Hint  = " ",
  Info  = " ",
}

-- git icons
M.git = {
  added    = " ",
  modified = " ",
  removed  = " ",
}
-- symbols = {
--   added = ' ',
--   modified = ' ',
--   removed = ' '
-- },

-- lsp kinds
M.kinds = {
  Array         = "",
  Boolean       = "󰨙",
  Class         = "",
  Codeium       = "󰘦",
  Color         = "",
  Control       = "",
  Collapsed     = "",
  Constant      = "󰏿",
  Constructor   = "",
  Copilot       = "",
  Enum          = "",
  EnumMember    = "",
  Event         = "",
  Field         = "󰜢",
  File          = "",
  Folder        = "",
  Function      = "󰊕",
  Interface     = "",
  Key           = "",
  Keyword       = "",
  Method        = "󰆧",
  Module        = "",
  Namespace     = "󰦮",
  Null          = "",
  Number        = "󰎠",
  Object        = "",
  Operator      = "",
  Package       = "",
  Property      = "",
  Reference     = "",
  Snippet       = "",
  String        = "",
  Struct        = "󰆼",
  TabNine       = "󰏚",
  Text          = "",
  TypeParameter = "",
  Unit          = "",
  Value         = "",
  Variable      = "󰀫",
}

return M
