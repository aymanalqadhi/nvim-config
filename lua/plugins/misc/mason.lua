local M = {}

-- plugin uri
M.uri = 'williamboman/mason.nvim'

-- plugin dependencies
M.dependencies = {
  'jose-elias-alvarez/null-ls.nvim',
  'jay-babu/mason-null-ls.nvim',
}

-- plugin options
M.lazy = true

-- plugin configuration
function M.configure()
  require('mason').setup({
    ui = {
      border = 'rounded',
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗'
      },
    },
  })

  -- null-ls integration
  require('mason-null-ls').setup { automatic_setup = true, }
  require('null-ls').setup {}
  require('mason-null-ls').setup_handlers() -- If `automatic_setup` is true.

end

return M
