local g = vim.g
local o = vim.opt

-- system integration
o.autowrite = true -- Enable auto write
o.clipboard = "unnamedplus" -- Sync with system clipboard
o.formatoptions = "jcroqlnt" -- tcqj
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.mouse = "a" -- Enable mouse mode

-- behaviour
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.inccommand = "nosplit" -- preview incremental substitute
o.splitbelow = true -- Put new windows below current
o.splitkeep = "screen"
o.splitright = true -- Put new windows right of current
o.timeoutlen = 300
o.undofile = true
o.undolevels = 10000
o.updatetime = 200 -- Save swap file and trigger CursorHold
o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
o.wildmode = "longest:full,full" -- Command-line completion mode
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" }
o.smoothscroll = true

-- editing
o.ignorecase = true -- Ignore case
o.smartcase = true -- Don't ignore case with capitals
o.expandtab = true -- Use spaces instead of tabs
o.shiftround = true -- Round indent
o.shiftwidth = 2 -- Size of an indent
o.tabstop = 2 -- Number of spaces tabs count for
o.smartindent = true -- Insert indents automatically
o.shortmess:append({ W = true, I = true, c = true, C = true })
o.spelllang = { "en" }
o.wrap = false -- Disable line wrap

-- appearance
o.title = true
o.termguicolors = true -- True color support
o.conceallevel = 3 -- Hide * markup for bold and italic
o.number = true -- Print line number
o.relativenumber = true -- Relative line numbers
--o.showmode = false -- Dont show mode since we have a statusline
o.pumblend = 15 -- Popup blend
o.winblend = 15
o.laststatus = 3 -- global statusline
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
o.colorcolumn = "80"
o.cursorline = true -- Enable highlighting of the current line
o.cursorcolumn = true -- Enable highlighting of the current column
o.scrolloff = 4 -- Lines of context
o.sidescrolloff = 8 -- Columns of context
o.fillchars = {
  eob = " ",
  fold = " ",
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  msgsep = "─",
  diff = "╱",
  vert = "▏",
}
o.listchars = {
  space = " ",
  trail = "⋅",
  tab = "  ",
  eol = "⌍",
  extends = "❯",
  precedes = "❮",
  nbsp = "␣",
}
o.statuscolumn = [[%!v:lua.require'util.ui'.statuscolumn()]]
o.winminwidth = 5 -- Minimum window width
o.visualbell = true

-- completion
o.completeopt = "menu,menuone,noselect,preview"
o.list = true -- Show some invisible characters (tabs...
o.pumheight = 10 -- Maximum number of entries in a popup

-- Folding
o.foldlevel = 99
o.foldtext = "v:lua.require'util.ui'.foldtext()"
-- o.foldtext = "v:lua.vim.treesitter.foldtext()"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldmethod = "expr"

-- misc
g.markdown_recommended_style = 0
o.formatexpr = "v:lua.require'util'.format.formatexpr()"
