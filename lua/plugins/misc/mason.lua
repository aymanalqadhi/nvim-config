local M = {}

-- plugin uri
M.uri = 'williamboman/mason.nvim'
--
-- plugin dependencies

-- plugin options
M.lazy = true
M.load_on_cmd = 'Mason'

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
end

return M
