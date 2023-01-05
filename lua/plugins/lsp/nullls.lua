local M = {}

-- plugin uri
M.uri = 'jose-elias-alvarez/null-ls.nvim'

-- plugin dependencies
M.dependencies = {
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-cmdline',
  'andersevenrud/cmp-tmux',
  'onsails/lspkind-nvim',
  'L3MON4D3/LuaSnip',
  'windwp/nvim-autopairs',
}

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  local null_ls = require("null-ls")

  local code_actions = null_ls.builtins.code_actions
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  local hover = null_ls.builtins.hover

  null_ls.setup {
    sources = {
      -- code actions
      code_actions.eslint_d,
      code_actions.gitsigns,
      code_actions.refactoring,

      -- formatters
      formatting.black,
      formatting.prettierd,
      formatting.clang_format,
      formatting.prettierd,
      formatting.dart_format,
      formatting.cmake_format,
      formatting.sqlfluff.with { extra_args = { "--dialect", "postgres" } },

      -- diagnostics
      diagnostics.eslint_d,
      diagnostics.yamllint,
      diagnostics.gitlint,
      diagnostics.cmake_lint,
      diagnostics.flake8,
      diagnostics.sqlfluff.with { extra_args = { "--dialect", "postgres" } },

      -- hover
      hover.printenv,
    },
  }
end

return M
