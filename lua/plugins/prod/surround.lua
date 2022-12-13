local M = {}

-- plugin uri
M.uri = 'kylechui/nvim-surround'

-- plugin configuration function
function M.configure()
  require("nvim-surround").setup {}
end

return M
