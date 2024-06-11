-- indentation
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- treesitter
vim.treesitter.start()
vim.bo.syntax = "on"
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
