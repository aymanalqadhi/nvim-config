-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- disable unneeded providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- set utilities global
_G.void = require("void")

-- load plugins
require("plugins").load()
