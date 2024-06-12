-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable unneeded providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- load configuration
require("void").setup()
