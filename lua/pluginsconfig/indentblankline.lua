local indent_blankline = require('indent_blankline')

return {
  configure = function()
      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")

      indent_blankline.setup {
        -- |, ¦, ┆, ┊
        char = "¦",
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
}

