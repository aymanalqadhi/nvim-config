local M = {}

-- plugin uri
M.uri = 'rmagatti/goto-preview'

-- plugin dependencies
M.dependencies = { 'nvim-telescope/telescope.nvim' }

-- plugin options
M.lazy = true
M.load_on_keys = 'gp'

-- plugin configuration function
function M.configure()
  require('goto-preview').setup {}
end

-- plugin keymaps
function M.set_keymaps(k)
  local gp = require('goto-preview')

  -- normal mode keys
  k.register({
    gp = {
      name = 'Go-To Preview',
      d = { gp.goto_preview_definition, 'Preview Definition' },
      t = { gp.goto_preview_type_definition, 'Preview Type Definition' },
      i = { gp.goto_preview_implementation, 'Preview Implementation' },
      r = { gp.goto_preview_references, 'Preview References' },
    },
    gP = { gp.close_all_win, 'Close Go-To Windows' },
  })

end

return M
