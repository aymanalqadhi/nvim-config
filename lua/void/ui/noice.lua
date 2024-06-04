return {
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
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },

    views = {
      cmdline_popup = { border = { style = "single" } },
      popupmenu = { border = { style = "single" } },
      mini = { win_options = { winblend = 0 } },
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
}
