local M = {}

-- plugin uri
M.uri = 'nvim-telescope/telescope.nvim'

-- plugin requirements
M.requires = {
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'nvim-telescope/telescope-file-browser.nvim',
}

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
        require("telescope.themes").get_dropdown {}
      },
      file_browser = {
        hijack_netrw = true,
      },
    },
  }

  -- extensions loading
  require('telescope').load_extension('ui-select')
  require('telescope').load_extension('file_browser')

end

-- plugin keymaps
function M.keymaps()
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')

  return {
    ['<space>f'] = {
      name = 'telescope',
      f = { builtin.find_files, 'Find Files' },
      F = { telescope.extensions.file_browser.file_browser, 'File Browser' },
      r = { builtin.live_grep, 'Find Text' },
      s = { builtin.live_grep, 'Find Occurrences' },
      b = { builtin.buffers, 'Buffers' },
      h = { builtin.help_tags, 'Help Tags' },
      q = { builtin.quickfix, 'Quick-fix List' },
      l = { builtin.loclist, 'Location List' },
      j = { builtin.jumplist, 'Jump List' },
      R = { builtin.registers, 'Registers' },
      p = { builtin.pickers, 'Pickers' },
      g = {
        name = 'telescope-git',
        b = { builtin.git_branches, 'Git Branches' },
        s = { builtin.git_status, 'Git Status' },
        S = { builtin.git_stash, 'Git Stashes' },
        h = { builtin.git_bcommits, 'File History' },
      },
    },
  }
end

return M
