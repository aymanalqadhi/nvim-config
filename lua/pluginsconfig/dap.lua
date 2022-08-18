local dap = require('dap')

local function configure_codelldb()
  -- server
  dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
      command = 'codelldb',
      args = { "--port", "${port}" },
      -- On windows you may have to uncomment this:
      -- detached = false,
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
      stopOnEntry = true,
    },
  }

  -- c
  dap.configurations.c = dap.configurations.cpp
  -- rust
  dap.configurations.rust = dap.configurations.cpp
end

local function configure()
  configure_codelldb()
end

return {
  configure = configure
}
