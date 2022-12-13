local M = {}

-- plugin uri
M.uri = 'numToStr/Comment.nvim'

-- plugin configuration function
function M.configure()
  require('Comment').setup()
end

return M
