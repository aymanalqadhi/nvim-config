local M = {}

-- plugin uri
M.uri = 'rcarriga/nvim-notify'

-- plugin configuration function
function M.configure()
  require('notify').setup {}
end

return M
