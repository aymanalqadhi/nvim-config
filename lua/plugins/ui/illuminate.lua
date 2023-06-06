local M = {}

-- plugin uri
M.uri = 'RRethy/vim-illuminate'

-- plugin configuration function
function M.configure()
  require('illuminate').configure {}
end

return M
