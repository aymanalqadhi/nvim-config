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
      selection_caret = " ",
      entry_prefix = " ",
      winblend = 15,
    },
  }

end

return M
