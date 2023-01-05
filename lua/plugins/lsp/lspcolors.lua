local M = {}

-- plugin uri
M.uri = 'folke/lsp-colors.nvim'
-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  require("lsp-colors").setup{}
end

return M
