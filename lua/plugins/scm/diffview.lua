local M = {}

-- plugin uri
M.uri = 'sindrets/diffview.nvim'

-- plugin requirements
M.requirements = { 'nvim-lua/plenary.nvim' }

-- plugin keymaps
function M.keymaps()
  return {
    ['<space>g'] = {
      name = 'git',
      h = { '<cmd>DiffviewFileHistory %f<cr>', 'Current File History' },
      H = { '<cmd>DiffviewFileHistory<cr>', 'Current File History' },
    }
  }
end

return M
