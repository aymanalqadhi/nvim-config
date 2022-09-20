local null_ls = require("null-ls")

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

local function configure()
  null_ls.setup {
    sources = {
      -- code actions
      code_actions.eslint_d,
      code_actions.gitsigns,
      code_actions.proselint,
      code_actions.refactoring,

      -- formatters
      formatting.black,
      formatting.eslint,
      formatting.rustfmt,
      formatting.prettier,
      formatting.clang_format,
      formatting.prettierd,
      formatting.dart_format,
      formatting.cmake_format,

      -- diagnostics
      diagnostics.eslint,
      diagnostics.yamllint,
      diagnostics.gitlint,
      diagnostics.flake8,
      diagnostics.eslint_d,
      diagnostics.codespell,
      diagnostics.cmake_lint,

      -- hover
      hover.printenv,
    },
    on_init = function(new_client, _)
      new_client.offset_encoding = 'utf-16'
    end,
  }
end

return {
  configure = configure
}
