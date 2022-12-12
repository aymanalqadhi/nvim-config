local M = {}

-- plugin uri
M.uri = 'rcarriga/nvim-notify'

-- plugin configuration function
function M.configure()
  require('notify').setup {
    background_colour = "#000000",
  }
end

return M
