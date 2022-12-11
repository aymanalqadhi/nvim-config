local plugin = {}

-- plugin uri
plugin.uri = 'goolord/alpha-nvim'

-- plugin requirements
plugin.requires = { 'kyazdani42/nvim-web-devicons' }

-- plugin configuration function
function plugin.configure()
  local dashboard = require('alpha.themes.dashboard')

  -- buttons definitions
  dashboard.section.buttons.val = {
    dashboard.button('<C-P>', '  Find file', ':Telescope find_files <CR>'),
    dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
    dashboard.button('p', '  Find project', ':Telescope projects <CR>'),
    dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
    dashboard.button('<CS-F>', '  Find text', ':Telescope live_grep <CR>'),
    dashboard.button('c', '  Configuration', ':e ~/.config/nvim/init.lua <CR>'),
    dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
  }

  -- footer generator using fortune
  local function footer()
    local handle = io.popen('fortune')

    if handle == nil then
      return ''
    end

    local fortune = handle:read('*a')
    handle:close()
    return fortune
  end

  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts.hl = 'Type'
  dashboard.section.header.opts.hl = 'Include'
  dashboard.section.buttons.opts.hl = 'Keyword'
  dashboard.opts.opts.noautocmd = true

  require('alpha').setup(dashboard.opts)
end

return plugin
