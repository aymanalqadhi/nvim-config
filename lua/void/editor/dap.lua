return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "williamboman/mason.nvim" }
    },
  },

  keys = {
    { "<leader>dd", desc = "dap: toggle breakpoint" },
    { "<leader>dc", desc = "dap: continue" },
    { "<leader>dq", desc = "dap: close" },
    { "<leader>dr", desc = "dap: restart" },
    { "<leader>di", desc = "dap: step into" },
    { "<leader>do", desc = "dap: step over" },
    { "<leader>dO", desc = "dap: step out" },
    { "<leader>db", desc = "dap: step back" },
  },

  config = function()
    local dap = require("dap")

    require("mason-nvim-dap").setup({
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      }
    })

    vim.keymap.set("n", "<leader>dd", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>dq", dap.close)
    vim.keymap.set("n", "<leader>dr", dap.restart)
    vim.keymap.set("n", "<leader>di", dap.step_into)
    vim.keymap.set("n", "<leader>do", dap.step_over)
    vim.keymap.set("n", "<leader>dO", dap.step_out)
    vim.keymap.set("n", "<leader>db", dap.step_back)

    dap.listeners.before.attach.dapui_config = function()
      require("dapui").open()
    end
    dap.listeners.before.launch.dapui_config = function()
      require("dapui").open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      require("dapui").close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      require("dapui").close()
    end
  end,

  {
    "rcarriga/nvim-dap-ui",

    lazy = true,

    dependencies = {
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },

    opts = {
      icons = { expanded = "", collapsed = "", current_frame = "" },
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.50, },
            { id = "breakpoints", size = 0.30 },
            { id = "watches",     size = 0.20 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 10,
          position = "bottom",
        },
      },
      floating = {
        border = "none",
        mappings = {
          ["close"] = { "q", "<esc>" },
        },
      },
      controls = {
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
          disconnect = "",
        },
      },
    },

    config = function(_, opts)
      require("dapui").setup(opts)
      require("nvim-dap-virtual-text").setup({})

      vim.keymap.set("n", "<leader>de", function()
        ---@diagnostic disable-next-line: missing-fields
        require("dapui").eval(nil, { enter = true })
      end, { desc = "dap: eval" })

      vim.fn.sign_define({
        { name = "DapStopped", text = "󰁕", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" },
        { name = "DapBreakpoint", text = "", texthl = "DiagnosticError" },
        { name = "DapBreakpointCondition", text = "", texthl = "DiagnosticInfo" },
        { name = "DapBreakpointRejected", text = "", texthl = "DiagnosticWarn" },
        { name = "DapLogPoint", text = ".>" },
      })
    end,
  }
}
