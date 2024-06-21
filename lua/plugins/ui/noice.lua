return {
  {
    "folke/noice.nvim",

    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",

    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          silent = true,
        },
      },

      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = "❯", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
        },
      },

      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },

      views = {
        cmdline_popup = { border = { style = Void.config.ui.border } },
        popupmenu = { border = { style = Void.config.ui.border } },
      },

      messages = {
        enabled = true,
        view = "mini",
      },

      notify = {
        enabled = true,
        view = "mini",
      },
    },
  },
  {
    "rcarriga/nvim-notify",

    keys = {
      {
        "<leader>nd",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "noice: dismiss all",
      },
    },

    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100, focusable = false })
      end,
    },
  },
}
