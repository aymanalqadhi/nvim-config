local M = {}

-- plugin uri
M.uri = 'L3MON4D3/LuaSnip'

-- plugin requirements
M.requirements = {
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',
}

-- plugin configuration function
function M.configure()
  require('luasnip.loaders.from_vscode').lazy_load()
end

return M
