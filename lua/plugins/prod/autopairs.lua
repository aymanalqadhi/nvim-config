local M = {}

-- plugin uri
M.uri = 'windwp/nvim-autopairs'

-- plugin configuration function
function M.configure()
  require('nvim-autopairs').setup()
end

return M
