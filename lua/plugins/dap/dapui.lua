local M = {}

-- plugin uri
M.uri = 'rcarriga/nvim-dap-ui'

-- plugin dependencies
M.dependencies = { 'mfussenegger/nvim-dap' }

-- plugin options
M.lazy = true
M.load_on_keys = '<space>duu'

-- plugin configuration function
function M.configure()
  local dap, dapui = require("dap"), require("dapui")

  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open {}
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close {}
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close {}
  end
end

-- plugin keymaps
function M.set_keymaps(k)

  -- normal mode keys
  k.register({
    du = {
      name = 'dap-ui',
      u = { require('dapui').toggle, 'Toggle dap-ui' },
      e = { require('dapui').eval, 'Evaluate' },
    }
  }, { prefix = '<space>' })

end

return M
