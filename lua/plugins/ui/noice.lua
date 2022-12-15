local M = {}

-- plugin uri
M.uri = 'folke/noice.nvim'

-- plugin requirements
M.requirements = {
  'MunifTanjim/nui.nvim',
  'rcarriga/nvim-notify',
}

-- plugin configuration function
function M.configure()
  require("noice").setup({
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
      inc_rename = true,
      lsp_doc_border = true,
    },
  })
end

return M