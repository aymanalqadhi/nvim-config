local M = {}

-- plugin uri
M.uri = 'rcarriga/nvim-dap-ui'

-- plugin dependencies
M.dependencies = {
  'mfussenegger/nvim-dap',
  'nvim-treesitter/nvim-treesitter',
  'theHamsta/nvim-dap-virtual-text',
}

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

  -- virtual text
  require("nvim-dap-virtual-text").setup {
    enabled = true,
    highlight_new_as_changed = true,
    commented = true,
    all_references = true,

    -- experimental features:
    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil,
  }
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
