--- general config ---
vim.o.encoding = "UTF-8"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 5
vim.o.inccommand = "nosplit"
vim.o.shortmess = "filnxtToOF" .. "I"
vim.o.magic = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.mouse = "a" -- disable mouse
vim.o.clipboard = "unnamedplus"
vim.o.swapfile = false
vim.o.title = true
vim.o.wildmenu = true
vim.o.updatetime = 250

-- better expression folding 
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- indentation config
vim.o.showmatch = true
vim.o.smartindent = true

-- split config
vim.o.splitright = true
vim.o.splitbelow = true

-- tabs config
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.smartindent = true

-- searching
vim.o.incsearch = true

--- appearance config ---
vim.o.syntax = 'on'
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.visualbell = true
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.colorcolumn = '80'
vim.o.conceallevel = 2
vim.o.lazyredraw = true
vim.o.signcolumn = 'yes'

--- per-filetype config
-- *.lua
vim.api.nvim_command [[
  autocmd FileType lua setlocal shiftwidth=2 softtabstop=2 expandtab
]]
