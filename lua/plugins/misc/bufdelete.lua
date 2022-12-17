local M = {}

-- plugin uri
M.uri = 'famiu/bufdelete.nvim'

-- plugin keymaps
function M.keymaps()
  return {
    ["<A-c>"] = { function() require('bufdelete').bufdelete(0) end, "Close a Buffer" },
  }
end

return M
