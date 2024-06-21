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
        cmdline_popup = {
          border = { style = Void.config.ui.border },
          win_options = { winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder" },
        },
        popupmenu = {
          border = { style = Void.config.ui.border },
          win_options = { winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder" },
        },
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
}
