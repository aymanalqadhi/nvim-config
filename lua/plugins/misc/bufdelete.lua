local M = {}

-- plugin uri
M.uri = 'famiu/bufdelete.nvim'

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    ["<A-c>"] = { function() require('bufdelete').bufdelete(0) end, "Close a Buffer" },
  })
end

return M
