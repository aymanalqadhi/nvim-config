local M = {}

-- plugin uri
M.uri = 'Kasama/nvim-custom-diagnostic-highlight'

-- plugin configuration function
function M.configure()
  require('nvim-custom-diagnostic-highlight').setup {}
end

return M
