local M = {}

-- plugin uri
M.uri = 'smiteshp/nvim-navic'

-- plugin dependencies
M.dependencies = { 'neovim/nvim-lspconfig'}

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration
function M.configure()
  require('nvim-navic').setup {
    highlight = true,
    separator = "  ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true
}
end

return M
