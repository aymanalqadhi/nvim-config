local M = {}

-- plugin uri
M.uri = 'L3MON4D3/LuaSnip'

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin dependencies
M.dependencies = {
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',
}

-- plugin configuration function
function M.configure()
  require('luasnip.loaders.from_vscode').lazy_load()
end

return M
