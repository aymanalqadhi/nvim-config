local M = {}

-- plugin uri
M.uri = 'simrat39/rust-tools.nvim'

-- plugin options
M.lazy = true
M.load_on_event = 'BufReadPost *.rs'

-- plugin dependencies
M.dependencies = {
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
    tools = {
      autoSetHints = true,
      runnables = {
        use_telescope = true
      },
      inlay_hints = {
        auto = false,
        show_parameter_hints = true,
        other_hints_prefix = "-> "
      },
    },
    server = {
      standalone = false,
      settings = {
        ['rust-analyzer'] = {
          hover = {
            actions = {
              enable = true,
              references = true,
            }
          },
          lens = {
            enable = true,
            location = 'above_name',
            references = true,
          },
          typing = {
            autoClosingAngleBrackets = {
              enalbe = true
            }
          },
          checkOnSave = {
            command = "clippy"
          },
          completion = {
            callable = {
              snippets = "fill_arguments"
            }
          }
        },
      },
    }
  }

  require('crates').setup()
end

-- plugin keymaps
function M.set_keymaps(k)
  local rt = require('rust-tools')

  -- normal mode keys
  k.register({
    r = {
      name = 'rust-tools',
      h = { rt.hover_actions.hover_actions, 'Hover Actions' },
      a = { rt.code_action_group.code_action_group, 'Code Actions' },
      e = { rt.expand_macro.expand_macro, 'Expand Macro' },
      m = { rt.parent_module.parent_module, 'Parent Module' },
    }
  }, { prefix = '<space>' })
end

return M
