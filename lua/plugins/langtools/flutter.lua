local M = {}

-- plugin uri
M.uri = 'akinsho/flutter-tools.nvim'

-- plugin options
M.lazy = true
M.filetypes = 'dart'

-- plugin dependencies
M.dependencies = { 'nvim-lua/plenary.nvim' }

-- plugin configuration function
function M.configure()
  require("flutter-tools").setup {
    decorations = {
      statusline = {
        app_version = true,
        device = true,
      }
    },
    debugger = {
      enabled = true,
      run_via_dap = true,
    },
    fvm = false,
    widget_guides = {
      enabled = true,
    },
    closing_tags = {
      prefix = "->",
    },
    dev_tools = {
      autostart = true,
      auto_open_browser = true,
    },
    lsp = {
      color = {
        enabled = true,
        background = true,
        foreground = true,
        virtual_text = true,
        virtual_text_str = "■",
      },
    }
  }
end

return M
