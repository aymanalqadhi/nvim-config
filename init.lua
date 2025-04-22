if not vim.fn.has("nvim-0.10") then
  vim.api.nvim_echo({ { "nvim >= 0.10 is required to load config", "ErrorMsg" } }, true, {})
  vim.fn.getchar()
  os.exit(1)
end

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable unneeded providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- set utilities global
-- selene: allow(global_usage)
_G.void = require("void")

-- load plugins
require("plugins").load()
