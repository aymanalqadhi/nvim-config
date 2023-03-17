local M = {}

-- plugin uri
M.uri = 'luukvbaal/statuscol.nvim'

-- plugin configuration function
function M.configure()
  require('statuscol').setup({
    relculright = true,
  })
end

return M
