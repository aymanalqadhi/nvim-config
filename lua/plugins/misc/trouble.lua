local M = {}

-- plugin uri
M.uri = 'folke/trouble.nvim'

-- plugin dependencies
M.dependencies = { 'nvim-tree/nvim-web-devicons' }

-- plugin options
M.lazy = true
M.load_on_keys = '<space>t'

-- plugin configuration function
function M.configure()
  require('trouble').setup {
    auto_open = false,
    auto_close = true,
    auto_fold = false,
    use_diagnostic_signs = true,
    -- signs = {
    --   error = '',
    --   warning = '',
    --   hint = '',
    --   information = '',
    --   other = '',
    -- },
  }
end

-- plugin keymaps
function M.set_keymaps(k)
  local trouble = require('trouble')
  local opts = { skip_groups = true, jump = true }

  -- normal mode keys
  k.register({
    ['<space>t'] = {
      name = 'trouble',
      t = { '<cmd>TroubleToggle<cr>', 'Toggle Trouble' },
      d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'Toggle Document Trouble' },
      w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Toggle Workspace Trouble' },
      l = { '<cmd>TroubleToggle loclist<cr>', 'Toggle Trouble LocList' },
      q = { '<cmd>TroubleToggle quickfix<cr>', 'Toggle Trouble QuickFix' },
    },
    [']t'] = { function() trouble.next(opts) end, 'Next Diagnostic' },
    ['[t'] = { function() trouble.previous(opts) end, 'Previous Diagnostic' },
    gtr = { '<cmd>TroubleToggle lsp_references<cr>', 'Lsp References' }
  }, { skip_groups = true, jump = true })
end

return M
