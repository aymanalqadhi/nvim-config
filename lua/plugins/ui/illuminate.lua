local M = {}

-- plugin uri
M.uri = 'RRethy/vim-illuminate'

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  require('illuminate').configure {}
end

return M
