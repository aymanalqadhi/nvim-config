local M = {}

-- plugin uri
M.uri = 'SmiteshP/nvim-navic'

-- plugin requirements
M.requirements = { 'neovim/nvim-lspconfig'}

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
