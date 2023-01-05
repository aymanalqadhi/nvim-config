local M = {}

-- plugin uri
M.uri = 'akinsho/toggleterm.nvim'

-- plugin options
M.lazy = true
M.load_on_keys = { [[<C-\>]], '<C-t>', '<A-g>' }

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
function M.set_keymaps(k)
  local term = require('toggleterm.terminal');

  -- normal mode keys
  k.register({
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
  })

  -- all modes except `terminal` keys
  k.register({
    ['<C-t>'] = {
      function()
        term.Terminal:new { direction = 'float' }:toggle()
      end,
      'Floating Terminal',
    },
  }, { mode = { 'n', 'i', 'v' } })

  -- terminal mode keys
  k.register({
    ['<C-t>'] = { '<cmd>ToggleTermToggleAll<cr>', 'Toggle All Terminals' },
    ['<C-h>'] = { '<cmd>wincmd h<cr>', 'Jump Left' },
    ['<C-j>'] = { '<cmd>wincmd h<cr>', 'Jump Up' },
    ['<C-k>'] = { '<cmd>wincmd h<cr>', 'Jump Down' },
    ['<C-l>'] = { '<cmd>wincmd h<cr>', 'Jump Right' },
  }, { mode = 't' })

end

return M
