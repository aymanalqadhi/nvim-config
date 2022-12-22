local M = {}

-- plugin uri
M.uri = 'akinsho/toggleterm.nvim'

-- plugin configuration function
function M.configure()
  require('toggleterm').setup {
    open_mapping = [[<C-\>]],
    shade_terminals = true,
    direction = 'horizontal',
    winblend = 15,
    float_opts = {
      border = 'curved',
      winblend = 15,
      width = math.ceil(vim.o.columns * 0.8),
      height = math.ceil(vim.o.columns * 0.2),
    },
    highlights = {
      FloatBorder = {
        guifg = '#27a1b9',
      },
    },
    winbar = {
      enabled = false,
      name_formatter = function(t)
        return '[+] Terminal #' .. t.id
      end
    },
  }

end

-- plugin keymaps
function M.keymaps()
  local term = require('toggleterm.terminal');

  return {
    -- lazygit
    ['<A-g>'] = {
      function()
        term.Terminal:new {
          cmd = 'lazygit',
          dir = 'git_dir',
          direction = 'float',
          hidden = true,
          on_open = function(t)
            vim.cmd('startinsert!')
            vim.api.nvim_buf_set_keymap(t.bufnr, 'n', 'q', '<cmd>close<CR>', {})
          end
        }:toggle()
      end,
      'Lazygit',
    },
    -- floating
    ['<C-t>'] = {
      {
        mode = { 'n', 'i', 'v' },
        function()
          term.Terminal:new {
            direction = 'float',
          }:toggle()
        end,
        'Floating Terminal',
      },
      {
        mode = 't',
        '<cmd>ToggleTermToggleAll<cr>',
        'Toggle All Terminals'
      },
    },
    ['<C-h>'] = { mode = 't', '<cmd>wincmd h<cr>', 'Jump Left' },
    ['<C-j>'] = { mode = 't', '<cmd>wincmd h<cr>', 'Jump Up' },
    ['<C-k>'] = { mode = 't', '<cmd>wincmd h<cr>', 'Jump Down' },
    ['<C-l>'] = { mode = 't', '<cmd>wincmd h<cr>', 'Jump Right' },
  }

end

return M
