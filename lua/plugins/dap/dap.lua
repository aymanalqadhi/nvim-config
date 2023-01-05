local M = {}

-- plugin uri
M.uri = 'mfussenegger/nvim-dap'

-- plugin options
M.lazy = true
M.load_on_keys = '<space>d'

-- plugin configuration function
function M.configure()
  local dap = require('dap')

  -- server
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = 'codelldb',
      args = { '--port', '${port}' },
    }
  }

  -- cpp client
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",

      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,

      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  }

  -- c, rust
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp

  -- better colors
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#993939', bg = '#31353f' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef', bg = '#31353f' })
  vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379', bg = '#31353f' })

  local function set_sign(group, icon, hl)
    vim.fn.sign_define(group, { text = icon, texthl = hl, linehl = '', numhl = hl })
  end

  -- better icons
  set_sign('DapBreakpoint', '', 'DapBreakpoint')
  set_sign('DapBreakpointCondition', 'ﳁ', 'DapBreakpoint')
  set_sign('DapBreakpointRejected', '', 'DapBreakpoint')
  set_sign('DapBreakpointRejected', '', 'DapBreakpoint')
  set_sign('DapLogPoint', '', 'DapLogPoint')
  set_sign('DapLogPoint', '', 'DapStopped')

  -- repl
  vim.cmd [[au FileType dap-repl lua require('dap.ext.autocompl').attach()]]

end

-- plugin keymaps
function M.set_keymaps(k)
  local dap = require('dap')

  -- normal mode keys
  k.register({
    d = {
      name = 'dap',

      bb = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
      bl = { dap.list_breakpoints, 'List Breakpoints' },
      bc = { dap.clear_breakpoints, 'Clear Breakpoints' },

      c = { dap.continue, 'Continue' },
      C = { dap.run_to_cursor, 'Run To Cursor' },
      i = { dap.step_in, 'Step In' },
      o = { dap.step_over, 'Step Over' },
      u = { dap.step_out, 'Step Out' },

      t = { dap.terminate, 'Terminate' },
      r = { dap.repl.toggle, 'Toggle REPL' },
    }
  }, { prefix = '<space>' })

end

return M
