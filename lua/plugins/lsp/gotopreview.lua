local M = {}

-- plugin uri
M.uri = 'rmagatti/goto-preview'

-- plugin requirements
M.requirements = { 'nvim-telescope/telescope.nvim' }

-- plugin configuration function
function M.configure()
  require('goto-preview').setup {}
end

-- plugin keymaps
function M.keymaps()
  local gp = require('goto-preview')

  return {
    gp = {
      name = 'Go-To Preview',
      d = { gp.goto_preview_definition(), desc = 'Preview Definition' },
      t = { gp.goto_preview_type_definition(), desc = 'Preview Type Definition' },
      i = { gp.goto_preview_implementation(), desc = 'Preview Implementation' },
      r = { gp.goto_preview_references(), desc = 'Preview References' },
    },
    gP = { gp.close_all_win(), desc = 'Close Go-To Windows' },
  }
end

return M
