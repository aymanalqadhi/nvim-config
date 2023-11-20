local M = {}

-- plugin uri
M.uri = 'm4xshen/hardtime.nvim'
--
-- plugin dependencies
M.dependencies = {
  'MunifTanjim/nui.nvim',
  'nvim-lua/plenary.nvim',
}

-- plugin configuration
function M.configure()
  require('hardtime').setup()
end

return M
