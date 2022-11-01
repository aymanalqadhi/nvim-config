local toggleterm = require('toggleterm')
local term = require('toggleterm.terminal');

local function configure()
  toggleterm.setup {
    open_mapping = [[<C-\>]],
    shade_terminals = true,
    direction = 'horizontal',
    winblend = 15,
    float_opts = {
      border = 'curved',
      winblend = 15,
    },
    winbar = {
      enabled = false,
      name_formatter = function(t)
        return '[+] Terminal #' .. t.id
      end
    },
  }

  _G.term_lazygit = term.Terminal:new {
    cmd = 'lazygit',
    dir = 'git_dir',
    direction = 'float',
    hidden = true,
  }

  _G.term_horizontal = term.Terminal:new {
    direction = 'float',
  }
end

return {
  configure = configure
}
