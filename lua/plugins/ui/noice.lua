local M = {}

-- plugin uri
M.uri = 'folke/noice.nvim'

-- plugin dependencies
M.dependencies = {
  'MunifTanjim/nui.nvim',
  'rcarriga/nvim-notify',
}

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  require('noice').setup({
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    views = {
      cmdline_popup = {
        border = {
          style = {
            top_left = '',
            top = '',
            top_right = '',
            right = '',
            bottom_right = '',
            bottom = '',
            bottom_left = '',
            left = { '│', 'NoiceFloatBorder' },
          },
          padding = { 1, 2 },
        },
        win_options = {
          winhighlight = {
            Normal = 'NoiceNormal',
            NormalFloat = 'NoiceFloatNormal',
          },
        },
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
  })
end

return M
