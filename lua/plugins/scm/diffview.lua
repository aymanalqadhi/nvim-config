local M = {}

-- plugin uri
M.uri = 'sindrets/diffview.nvim'

-- plugin dependencies
M.dependencies = { 'nvim-lua/plenary.nvim' }

-- plugin options
M.lazy = true
M.load_on_keys = '<space>g'

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    g = {
      name = 'git',
      h = { '<cmd>DiffviewFileHistory %f<cr>', 'Current File History' },
      H = { '<cmd>DiffviewFileHistory<cr>', 'Current File History' },
    }
  }, { prefix = '<space>' })

end

return M
