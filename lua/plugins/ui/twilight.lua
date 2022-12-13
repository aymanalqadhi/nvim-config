local M = {}

-- plugin uri
M.uri = 'folke/twilight.nvim'

-- plugin configuration function
function M.configure()
  require('twilight').setup {
    dimming = {
      alpha = 0.5,
    }
  }
end

return M
