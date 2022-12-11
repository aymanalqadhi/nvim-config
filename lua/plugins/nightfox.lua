local M = {}

-- plugin uri
M.uri = 'EdenEast/nightfox.nvim'

-- plugin configuration function
function M.configure()
  require('nightfox').setup({
    options = {
      transparent = false,
      terminal_colors = true,
      dim_inactive = false,
      module_default = true,
      styles = {
        comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
        conditionals = 'NONE',
        constants = 'NONE',
        functions = 'NONE',
        keywords = 'bold',
        numbers = 'NONE',
        operators = 'NONE',
        strings = 'NONE',
        --types = 'NONE',
        types = 'italic,bold',
        variables = 'NONE',
      },
      inverse = {
        match_paren = false,
        visual = false,
        search = false,
      },
    },
  })

  vim.cmd [[ colorscheme nordfox ]]
end

return M
