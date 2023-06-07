local M = {}

-- plugin uri
M.uri = 'jose-elias-alvarez/null-ls.nvim'

-- plugin dependencies
M.dependencies = 'jay-babu/mason-null-ls.nvim'

-- plugin options
M.lazy = true
M.filetypes = { 'python' }

-- plugin configuration
function M.configure()
  require('mason-null-ls').setup { automatic_setup = true, }
  require('null-ls').setup {}
end

return M
