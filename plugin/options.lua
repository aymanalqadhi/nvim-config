local opt     = vim.opt

-- system integration
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.mouse     = "a"           -- Enable mouse mode
opt.formatoptions:remove "o"

-- behaviour
opt.inccommand     = "split"
opt.splitbelow     = true
opt.splitright     = true
opt.undofile       = true
opt.undolevels     = 10000
opt.shada          = { "'10", "<0", "s10", "h" }
opt.timeout        = true
opt.timeoutlen     = 300
opt.updatetime     = 300

-- editing
opt.ignorecase     = true
opt.smartcase      = true
opt.expandtab      = true
opt.smartindent    = true
opt.wrap           = false
opt.number         = true
opt.relativenumber = true
opt.scrolloff      = 4
opt.sidescrolloff  = 8
opt.completeopt    = { "menu", "menuone", "noselect" }
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.tabstop       = 4
opt.shiftwidth    = 4
opt.softtabstop   = 4
opt.expandtab     = true

-- appearance
opt.title         = true
opt.termguicolors = true
opt.winblend      = 0
opt.pumblend      = 0
opt.pumheight     = 10
opt.signcolumn    = "yes"
opt.colorcolumn   = "80"
opt.cursorline    = true
opt.cursorcolumn  = true
opt.showmode      = false
opt.cmdheight     = 1
opt.conceallevel  = 3
opt.visualbell    = true
opt.fillchars     = {
  eob = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  msgsep = "─",
  diff = "╱",
  vert = "▏",
}
opt.listchars     = {
  space = " ",
  trail = "⋅",
  tab = "  ▸",
  -- eol = "↵" | "⌍" | "↩",
  extends = "❯",
  precedes = "❮",
  nbsp = "␣",
}
