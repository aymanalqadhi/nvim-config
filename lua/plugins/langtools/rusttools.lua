local M = {}

-- plugin uri
M.uri = 'simrat39/rust-tools.nvim'

-- plugin requirements
M.requirements = {
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  'mfussenegger/nvim-dap',
  'saecki/crates.nvim',
}

-- plugin configuration function
function M.configure()
  local rt = require('rust-tools')
  local rt_dap = require('rust-tools.dap')

  local mason_reg = require('mason-registry')
  local ext_path = mason_reg.get_package('codelldb'):get_install_path()
  local codelldb_path = ext_path .. '/extension/adapter/codelldb'
  local liblldb_path = ext_path .. '/extension/lldb/lib/liblldb.so'

  rt.setup {
    dap = {
      adapter = rt_dap.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }

  require('crates').setup()
end

-- plugin keymaps
function M.keymaps()
  local rt = require('rust-tools')

  return {
    ['<space>r'] = {
      name = 'rust-tools',
      h = { function() rt.hover_actions.hover_actions() end, 'Hover Actions' },
      a = { function() rt.code_action_group.code_action_group() end, 'Code Actions' },
      e = { function() rt.expand_macro.expand_macro() end, 'Expand Macro' },
      m = { function() rt.parent_module.parent_module() end, 'Parent Module' },
    }
  }
end

return M