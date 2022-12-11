local plugin = {}

-- plugin uri
plugin.uri = 'shaunsingh/nord.nvim'

-- plugin configuration function
function plugin.configure()
  vim.g.nord_contrast = false
  vim.g.nord_borders = false
  vim.g.nord_disable_background = false
  vim.g.nord_cursorline_transparent = false
  vim.g.nord_enable_sidebar_background = false
  vim.g.nord_italic = true
  vim.g.nord_uniform_diff_background = false
  vim.g.nord_bold = true

  require('nord').set()
end

return plugin
