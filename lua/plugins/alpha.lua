return {
  'goolord/alpha-nvim',

  -- requires `nvim-web-devicons` to display icons
  requires = {
    'kyazdani42/nvim-web-devicons'
  },

  -- configuration function
  config = function()
    local db = require('alpha.themes.dashboard')

    -- buttons definitions
    db.section.buttons.val = {
      db.button('<C-P>', '  Find file', ':Telescope find_files <CR>'),
      db.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
      db.button('p', '  Find project', ':Telescope projects <CR>'),
      db.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
      db.button('<CS-F>', '  Find text', ':Telescope live_grep <CR>'),
      db.button('c', '  Configuration', ':e ~/.config/nvim/init.lua <CR>'),
      db.button('q', '  Quit Neovim', ':qa<CR>'),
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

    db.section.footer.val = footer()
    db.section.footer.opts.hl = 'Type'
    db.section.header.opts.hl = 'Include'
    db.section.buttons.opts.hl = 'Keyword'
    db.opts.opts.noautocmd = true

    vim.cmd([[autocmd User AlphaReady echo 'ready']])

    require('alpha').setup(db.opts)
  end
}
