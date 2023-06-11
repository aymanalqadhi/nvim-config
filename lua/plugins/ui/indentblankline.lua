local M = {}

-- plugin uri
M.uri = 'lukas-reineke/indent-blankline.nvim'

-- plugin options
M.lazy = true
M.load_on_event = 'BufRead'

-- plugin configuration function
function M.configure()
  vim.opt.list = true
  vim.opt.listchars:append("eol:⌍")
  --vim.opt.listchars:append("space:·")

  require("indent_blankline").setup {
    char = '¦',
    context_char = '¦',
    show_current_context = true,
    show_trailing_blankline_indent = true,
    use_treesitter = true,
    filetype_exclude = { 'dashboard' },
  }
end

return M
