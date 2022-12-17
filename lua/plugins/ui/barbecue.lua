local M = {}

-- plugin uri
M.uri = 'utilyre/barbecue.nvim'

-- plugin requirements
M.requirements = {
  'neovim/nvim-lspconfig',
  'smiteshp/nvim-navic',
  'kyazdani42/nvim-web-devicons',
}

-- plugin configuration function
function M.configure()
  require('barbecue').setup {}
end

return M
