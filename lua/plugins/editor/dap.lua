return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-dap.nvim",
      {
        "jay-babu/mason-nvim-dap.nvim",

        dependencies = { "williamboman/mason.nvim" },
        lazy = true,

        opts = {
          ensure_installed = {},
          automatic_installation = false,
          handlers = {
            function(config)
              require("mason-nvim-dap").default_setup(config)
            end,
          },
        },
      },
    },

    keys = function()
      local function act(f, ...)
        local args = { ... }
        return function()
          require("dap")[f](unpack(args))
        end
      end

      local function pick(n, theme)
        return function()
          local opts = theme and require("plugins.tooling.telescope.pickers")[theme]() or {}
          require("telescope").extensions.dap[n](opts)
        end
      end

      return {
        -- actions
        { "<leader>dd", act("toggle_breakpoint"), desc = "dap: toggle breakpoint" },
        { "<leader>dc", act("continue"), desc = "dap: continue" },
        { "<leader>dC", act("run_to_cursor"), desc = "dap: run to cursor" },
        { "<leader>dp", act("run_last"), desc = "dap: run last target" },
        { "<leader>dp", act("pause"), desc = "dap: pause" },
        { "<leader>dx", act("close"), desc = "dap: close" },
        { "<leader>dX", act("restart"), desc = "dap: restart" },
        { "<leader>dq", act("terminate"), desc = "dap: terminate" },
        -- navgiation
        { "<leader>dnu", act("up"), desc = "dap: stack up" },
        { "<leader>dnd", act("down"), desc = "dap: stack down" },
        { "<leader>di", act("step_into"), desc = "dap: step into" },
        { "<leader>do", act("step_over"), desc = "dap: step over" },
        { "<leader>dO", act("step_out"), desc = "dap: step out" },
        { "<leader>db", act("step_back"), desc = "dap: step back" },
        { "<leader>dr", act("repl_open"), desc = "dap: open repl" },
        -- pickers
        { "<leader>dlc", pick("commands", "dropdown"), desc = "dap: list commands" },
        { "<leader>dlC", pick("configurations", "dropdown"), desc = "dap: list configurations" },
        { "<leader>dlb", pick("list_breakpoints", "ivy"), desc = "dap: list breakpoints" },
        { "<leader>dlv", pick("variables", "dropdown"), desc = "dap: list variables" },
        { "<leader>dlf", pick("frames", "ivy"), desc = "dap: list frames" },
      }
    end,

    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",

    lazy = true,

    dependencies = {
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },

    keys = {
      {
        "<leader>duu",
        function()
          require("dapui").toggle()
        end,
        desc = "dap: toggle ui",
      },
      {
        "<leader>dur",
        function()
          require("dapui").close()
          require("dapui").open({ reset = true })
        end,
        desc = "dap: reset ui",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        desc = "dap: eval",
      },
      {
        "<leader>dus",
        function()
          require("dapui").float_element("stacks", {
            title = "Stacks",
            height = 32,
            enter = true,
          })
        end,
        desc = "dap: open stacks float",
      },
    },

    opts = {
      icons = { expanded = "", collapsed = "", current_frame = "" },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.80 },
            { id = "breakpoints", size = 0.10 },
            { id = "watches", size = 0.10 },
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
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    },

    config = function(_, opts)
      require("dapui").setup(opts)
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-dap-virtual-text").setup({})
    end,

    init = function()
      local icons = void.config.icons

      vim.fn.sign_define({
        {
          name = "DapStopped",
          text = icons.debug.Stopped,
          texthl = "DiagnosticWarn",
          linehl = "DapStoppedLine",
          numhl = "DapStoppedLine",
        },
        {
          name = "DapBreakpoint",
          text = icons.debug.Breakpoint,
          texthl = "DiagnosticError",
        },
        {
          name = "DapBreakpointCondition",
          text = icons.debug.BreakpointConditional,
          texthl = "DiagnosticInfo",
        },
        {
          name = "DapBreakpointRejected",
          text = icons.debug.BreakpointRejected,
          texthl = "DiagnosticWarn",
        },
        {
          name = "DapLogPoint",
          text = icons.debug.LogPoint,
        },
      })
    end,
  },
}
