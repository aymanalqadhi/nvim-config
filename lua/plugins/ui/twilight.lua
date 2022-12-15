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

-- plugin keymaps
function M.keymaps()
  return {
    ['<space>T'] = { '<cmd>Twilight<cr>', 'Toggle Twilight' }
  }
end

return M
