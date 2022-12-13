local M = {}

-- plugin uri
M.uri = 'lukas-reineke/indent-blankline.nvim'

-- plugin configuration function
function M.configure()
  vim.opt.list = true
  vim.opt.listchars:append("eol:↴")
  vim.opt.listchars:append("space:⋅")

  require("indent_blankline").setup {
    show_end_of_line = true,
    show_current_context = true,
    show_current_context_start = true,
    space_char_blankline = " ",
  }

end

return M
