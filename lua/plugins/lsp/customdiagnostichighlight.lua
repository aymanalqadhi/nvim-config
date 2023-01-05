local M = {}

-- plugin uri
M.uri = 'Kasama/nvim-custom-diagnostic-highlight'

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  require('nvim-custom-diagnostic-highlight').setup {}
end

return M
