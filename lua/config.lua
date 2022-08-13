--- general config ---
vim.o.encoding = "UTF-8"
vim.o.completeopt = "menuone,noselect"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 5
vim.o.inccommand = "nosplit"
vim.o.shortmess = "filnxtToOF" .. "I"
vim.o.magic = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.mouse = '' -- disable mouse

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

--- apperance config ---
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

-- colorscheme
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
vim.cmd("colorscheme tokyodark")

--- per-filetype config
-- *.lua
vim.api.nvim_command [[
  autocmd FileType lua setlocal shiftwidth=2 softtabstop=2 expandtab
]]
