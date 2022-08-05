--- general config ---
vim.o.encoding= "UTF-8"
vim.o.completeopt = "menuone,noselect"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 5
vim.o.inccommand = "nosplit"
vim.o.shortmess = "filnxtToOF" .. "I"

-- indentation config
vim.o.showmatch = true
vim.o.smartindent = true

-- split config
vim.o.splitright = true
vim.o.splitbelow = true

-- tabs config
vim.o.expandtab = true
vim.o.tabstop= 2
vim.o.shiftwidth= 2
vim.o.softtabstop= 2

-- searching
vim.o.incsearch = true

--- apperance config ---
vim.o.syntax = 'on'
vim.o.termguicolors = true
vim.o.background= 'dark'
vim.o.visualbell = true
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.colorcolumn = "80"
vim.o.conceallevel = 2
vim.o.lazyredraw = true

-- colorscheme
vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1
vim.cmd 'colorscheme onedarkpro'

-- enable transparency
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi LineNr guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE
]]

--- per-filetype config
-- *.lua
vim.api.nvim_command [[
  autocmd FileType lua setlocal shiftwidth=4 softtabstop=4 expandtab
]]
