local M = {}

-- plugin uri
M.uri = 'jose-elias-alvarez/null-ls.nvim'

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
      formatting.cmake_format,
      formatting.black,
      formatting.prettierd,
      formatting.prettierd,
      formatting.dart_format,
      formatting.sqlfluff.with { extra_args = { "--dialect", "postgres" } },

      -- diagnostics
      diagnostics.cmake_lint,
      diagnostics.eslint_d,
      diagnostics.flake8,
      diagnostics.gitlint,
      diagnostics.sqlfluff.with { extra_args = { "--dialect", "postgres" } },
      diagnostics.yamllint,

      -- hover
      hover.printenv,
    },
  }
end

return M
