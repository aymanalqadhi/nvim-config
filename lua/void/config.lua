local M = {}

-- completion config
M.completion = {
  sources = {
    lazydev  = { display = "LazyDev", group = 0 },
    crates   = { display = "Crates", group = 1 },
    copilot  = { display = "Copilot", group = 2 },
    nvim_lsp = { display = "LSP", group = 2 },
    luasnip  = { display = "LuaSnip", group = 2 },
    path     = { display = "Path", group = 4 },
    buffer   = { display = "Buffer", group = 4 },
  },
}

-- UI config
M.ui = {
  -- borders
  border         = "single",
  borderchars    = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

  -- opacity
  float_winblend = 0,
}

-- icons
M.icons = {
  Cog         = "",
  Question    = "",
  Recording   = "󰑋",

  -- completion kinds
  kinds       = {
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
  },

  -- debugging
  debug       = {
    Stopped = "󰁕",
    Breakpoint = "",
    BreakpointConditional = "",
    BreakpointRejected = "",
    LogPoint = ".>",
  },

  -- diagnostics
  diagnostics = {
    prefix = "●",
    signs = {
      Error   = " ",
      Warning = " ",
      Info    = " ",
      Hint    = " ",
    },
  },

  -- buffer status
  buffer      = {
    Modified  = "",
    NewFile   = "󰐙",
    Readonly  = "",
    Unnamed   = "",
    Directory = "󰊱",
  },

  -- git
  git         = {
    Added    = " ",
    Modified = " ",
    Removed  = " ",
    Branch   = "",
  },

  -- mode
  modes       = {
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
  },
}

return M
