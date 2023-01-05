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
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    T = { '<cmd>Twilight<cr>', 'Toggle Twilight' }
  }, { prefix = '<space>' })

end

return M
