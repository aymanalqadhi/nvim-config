local M = {}

-- completion kinds
M.completion = {
  kinds = {
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
    Field         = "",
    File          = "",
    Folder        = "",
    Function      = "󰊕",
    Interface     = "",
    Key           = "",
    Keyword       = "󰌋",
    Method        = "󰊕",
    Module        = "",
    Namespace     = "󰦮",
    Null          = "󰟢",
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
    TypeParameter = "󰆩",
    Unit          = "",
    Value         = "",
    Variable      = "󰀫",
  }
}

-- debugging
M.debug = {
  Stopped = "󰁕",
  Breakpoint = "",
  BreakpointConditional = "",
  BreakpointRejected = "",
  LogPoint = ".>",
}


-- diagnostics
M.diagnostics = {
  prefix = "●",
  signs = {
    Error   = " ",
    Warning = " ",
    Info    = " ",
    Hint    = " ",
  }
}

-- buffer status
M.buffer = {
  Modified  = "",
  NewFile   = "󰐙",
  Readonly  = "",
  Unnamed   = "",
  Directory = "󰊱"
}

-- git
M.git = {
  Added    = " ",
  Modified = " ",
  Removed  = " ",
  Branch   = "",
}

-- misc
M.misc = {
  Cog       = "",
  Recording = "󰑋",
  Question  = "",
}

-- mode
M.modes = {
  -- builtin
  Command        = "  ",
  Insert         = "  ",
  Normal         = "  ",
  Replace        = "  ",
  ReplaceVirtual = "  ",
  Select         = "  ",
  Terminal       = " $ ",
  Visual         = " 󰘖 ",
  VisualLine     = " 󰡏 ",
  VisualBlock    = " 󰁌 ",

  -- extra
  Confirm        = " ᐅ ",
  Enter          = "  ",
  More           = "  ",
  Shell          = "  ",
}

return M
