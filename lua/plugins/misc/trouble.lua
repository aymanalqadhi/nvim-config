local M = {}

-- plugin uri
M.uri = 'folke/trouble.nvim'

-- plugin requirements
M.requirements = { 'kyazdani42/nvim-web-devicons' }

-- plugin configuration function
function M.configure()
  require('trouble').setup {
    auto_open = true,
    auto_close = true,
    use_diagnostic_signs = true,
  }

end

-- plugin keymaps
function M.keymaps()
  local trouble = require('trouble')

  return {
    ['<space>t'] = {
      name = 'trouble',
      t = { '<cmd>TroubleToggle<cr>', 'Toggle Trouble' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Toggle Document Trouble' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Toggle Workspace Trouble' },
      l = { '<cmd>TroubleToggle loclist<cr>', 'Toggle Trouble LocList' },
      q = { '<cmd>TroubleToggle quickfix<cr>', 'Toggle Trouble QuickFix' },
    },
    [']t'] = { trouble.next { skip_groups = true, jump = true }, 'Next Diagnostic' },
    ['[t'] = { trouble.previous { skip_groups = true, jump = true }, 'Previous Diagnostic' },
  }

end

return M
