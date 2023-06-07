local M = {}

-- plugin uri
M.uri = 'ggandor/leap.nvim'

-- plugin options
M.lazy = true
M.load_on_keys = 's'

-- plugin configuration function
function M.configure()
  require('leap').set_default_keymaps()
end

return M
