local M = {}

-- plugin uri
M.uri = 'folke/lsp-colors.nvim'

-- plugin configuration function
function M.configure()
  require("lsp-colors").setup{}
end

return M
