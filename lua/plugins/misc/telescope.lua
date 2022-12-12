local M = {}

-- plugin uri
M.uri = 'nvim-telescope/telescope.nvim'

-- plugin requirements
M.requires = { 'nvim-lua/plenary.nvim' }

-- plugin configuration function
function M.configure()

  require("telescope").setup {
    defaults = {
      prompt_prefix = "  ",
      selection_caret = "›",
      entry_prefix = " ",
      winblend = 15,
    },
  }

end

-- plugin keymaps
function M.keymaps()
  local builtin = require('telescope.builtin')

  return {
    ['<space>f'] = {
      name = 'telescope',
      f = { builtin.find_files, 'Find Files' },
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
