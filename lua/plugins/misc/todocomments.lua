local M = {}

-- plugin uri
M.uri = 'folke/todo-comments.nvim'

-- plugin configuration function
function M.configure()
  require('todo-comments').setup()
end

return M
