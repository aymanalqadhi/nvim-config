local M = {}

-- plugin uri
M.uri = 'nvim-telescope/telescope.nvim'

-- plugin dependencies
M.dependencies = {
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
  'rcarriga/nvim-notify',
}

-- plugin options
M.lazy = true
M.load_on_cmd = 'Telescope'
M.load_on_keys = '<space>f'

-- plugin configuration function
function M.configure()
  require('telescope').setup {
    defaults = {
      prompt_prefix = '  ',
      selection_caret = ' ',
      entry_prefix = ' ',
      winblend = 15,
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown {}
      },
    },
  }

  -- extensions loading
  require('telescope').load_extension('ui-select')
  require('telescope').load_extension('file_browser')
end

-- plugin keymaps
function M.set_keymaps(k)
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')

  -- normal mode keys
  k.register({
    f = {
      name = 'telescope',
      f = { builtin.find_files, 'Find Files' },
      F = { telescope.extensions.file_browser.file_browser, 'File Browser' },
      r = { builtin.live_grep, 'Find Text' },
      s = { builtin.grep_string, 'Find Occurrences' },
      b = { builtin.buffers, 'Buffers' },
      h = { builtin.help_tags, 'Help Tags' },
      q = { builtin.quickfix, 'Quick-fix List' },
      l = { builtin.loclist, 'Location List' },
      j = { builtin.jumplist, 'Jump List' },
      R = { builtin.registers, 'Registers' },
      p = { builtin.pickers, 'Pickers' },
      -- git
      g = {
        name = 'telescope-git',
        b = { builtin.git_branches, 'Git Branches' },
        s = { builtin.git_status, 'Git Status' },
        S = { builtin.git_stash, 'Git Stashes' },
        h = { builtin.git_bcommits, 'File History' },
      },
      -- notify
      n = { '<cmd>Telescope notify<cr>', 'Notifications' },
    },
  }, { prefix = '<space>' })
end

return M
