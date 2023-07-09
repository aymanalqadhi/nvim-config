local M = {}

-- plugin uri
M.uri = 'p00f/clangd_extensions.nvim'

-- plugin options
M.lazy = true
M.filetypes = { 'c', 'cpp' }

-- plugin dependencies
M.dependencies = {
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  'mfussenegger/nvim-dap',
  'saecki/crates.nvim',
}

-- plugin configuration function
function M.configure()
  local icons = require('common.icons').lsp_kinds

  require('clangd_extensions').setup {
    server = {
      cmd = {
        'clangd',
        '--offset-encoding=utf-16',
      },
    },
    extensions = {
      autoSetHints = true,
      inlay_hints = {
        inline = vim.fn.has('nvim-0.10') == 1,
        only_current_line = false,
        only_current_line_autocmd = 'CursorHold',
        show_parameter_hints = true,
        parameter_hints_prefix = '<- ',
        other_hints_prefix = '=> ',
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = 'Comment',
        priority = 100,
      },
      ast = {
        role_icons = {
          type = icons.Type,
          declaration = icons.Declaration,
          expression = icons.Constant,
          statement = icons.Event,
          specifier = icons.Specifier,
          ['template argument'] = icons.TypeParameter,
        },
        kind_icons = {
          Compound = icons.Statement,
          Recovery = icons.BreakStatement,
          TranslationUnit = icons.Module,
          PackExpansion = icons.SwitchStatement,
          TemplateTypeParm = icons.TypeParameter,
          TemplateTemplateParm = icons.Repeat,
          TemplateParamObject = icons.Object,
        },
        highlights = {
          detail = 'Comment',
        },
      },
      memory_usage = {
        border = 'none',
      },
      symbol_info = {
        border = 'none',
      },
    },
  }
end

return M
