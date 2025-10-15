local opt = vim.opt

-- system integration
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.formatoptions:remove("o")

-- behaviour
opt.inccommand = "split"
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.undofile = true
opt.undolevels = 10000
opt.shada = { "'10", "<0", "s10", "h" }
opt.timeout = true
opt.timeoutlen = 300
opt.updatetime = 300
opt.whichwrap:append("<>[]hl")

-- editing
opt.confirm = true
opt.ignorecase = true
opt.smartcase = true
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.smoothscroll = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.tabstop = 4
opt.shiftround = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.spelllang = { "en" }

-- appearance
opt.title = true
opt.termguicolors = true
opt.winblend = 10
opt.pumblend = 10
opt.pumheight = 12
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.cursorline = true
opt.cursorcolumn = true
opt.showmode = false
opt.cmdheight = 1
opt.conceallevel = 3
opt.visualbell = true
opt.fillchars = {
  eob = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  msgsep = "─",
  diff = "╱",
  vert = "▏",
}
opt.list = true
opt.listchars = {
  space = " ",
  trail = "⋅",
  tab = "  ▸",
  -- eol = "¬",
  extends = "❯",
  precedes = "❮",
  nbsp = "␣",
}
