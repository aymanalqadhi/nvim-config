local dap = require('dap')

local function configure_codelldb()
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

  -- signs
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#993939', bg = '#31353f' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef', bg = '#31353f' })
  vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379', bg = '#31353f' })

  local function set_sign(group, icon, hl)
    vim.fn.sign_define(group, { text = icon, texthl = hl, linehl = '', numhl = hl})
  end

  set_sign('DapBreakpoint', '', 'DapBreakpoint')
  set_sign('DapBreakpointCondition', 'ﳁ', 'DapBreakpoint')
  set_sign('DapBreakpointRejected', '', 'DapBreakpoint')
  set_sign('DapBreakpointRejected', '', 'DapBreakpoint')
  set_sign('DapLogPoint', '', 'DapLogPoint')
  set_sign('DapLogPoint', '', 'DapStopped')
end

local function configure()
  configure_codelldb()
end

return {
  configure = configure
}
