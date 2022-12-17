local M = {}

-- plugin uri
M.uri = 'levouh/tint.nvim'

-- plugin configuration function
function M.configure()
  require('tint').setup({
    tint = -45,
    saturation = 0.6,
    transforms = require("tint").transforms.SATURATE_TINT,
    tint_background_colors = false,
    highlight_ignore_patterns = { 'WinSeparator', 'Status.*', },
    window_ignore_function = function(winid)
      local bufid = vim.api.nvim_win_get_buf(winid)

      return --string.find(vim.api.nvim_buf_get_name(bufid), 'NvimTree') or
             vim.api.nvim_buf_get_option(bufid, 'buftype') == 'terminal' or
             vim.api.nvim_win_get_config(winid).relative ~= ''
    end
  })
end

return M
