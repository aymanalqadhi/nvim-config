local M = {}

-- plugin uri
M.uri = 'ggandor/leap.nvim'

-- plugin configuration function
function M.configure()
  require('leap').set_default_keymaps()
end

return M
