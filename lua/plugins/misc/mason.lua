local M = {}

-- plugin uri
M.uri = 'williamboman/mason.nvim'

-- plugin options
M.lazy = true

-- plugin configuration
function M.configure()
  require("mason").setup({
    ui = {
      border = 'rounded',
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      },
    },
  })
end

return M
