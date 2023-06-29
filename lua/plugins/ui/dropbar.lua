local M = {}

-- plugin uri
M.uri = 'Bekaboo/dropbar.nvim'

-- plugin dependencies
M.dependencies = 'nvim-tree/nvim-web-devicons'

-- plugin configuration function
function M.configure()
  local icons = require('common.icons')

  require('dropbar').setup {
    general = {
      enable =
          function(buf, win)
            return not vim.api.nvim_win_get_config(win).zindex
                and vim.bo[buf].buftype == ''
                and vim.api.nvim_buf_get_name(buf) ~= ''
                and not vim.wo[win].diff
          end,
      kinds = icons.lsp_kinds,
      ui = {
        bar = {
          separator = ' ',
          extends = '…',
        },
        menu = {
          separator = ' ',
          indicator = ' ',
        },
      },
    },
  }
end

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    ['<C-s>'] = { require('dropbar.api').pick, 'Pick a Context Symbol' }
  })
end

return M
