return {
  {
    "folke/noice.nvim",

    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",

    config = function()
      local popup_view = {
        border = {
          style = void.config.ui.border
        },
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
        },
      }

      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            silent = true,
          },
          progress = {
            throttle = 10, -- ms
          }
        },

        cmdline = {
          format = {
            cmdline = { pattern = "^:", icon = "❯", lang = "vim", title = " Cmd " },
            search_down = { kind = "search", pattern = "^/", icon = "    ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "    ", lang = "regex" },
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
          cmdline_popup = popup_view,
          cmdline_input = popup_view,
        },

        messages = {
          enabled = true,
          view = "mini",
        },

        notify = {
          enabled = true,
          view = "mini",
        },
      }
      )
    end
  },
}
