local M = {}

-- plugin uri
M.uri = 'nvim-treesitter/nvim-treesitter'

-- plugin requirements
M.requirements = {
  'nvim-treesitter/nvim-treesitter-textobjects'
}

-- plugin configuration function
function M.configure()

  require('nvim-treesitter.configs').setup {
    -- auto install missing parsers
    auto_install = true,

    -- highlighting module
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    -- advanced text objects
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = { query = '@function.outer', 'A Function' },
          ['if'] = { query = '@function.inner', 'In Function' },
          ['ac'] = { query = '@class.outer', 'A Class' },
          ['ic'] = { query = '@class.in', 'In Class' },
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = { query = '@function.outer', 'Next Function Start' },
          [']]'] = { query = '@class.outer', 'Next Class Start' },
        },
        goto_next_end = {
          [']M'] = { query = '@function.outer', 'Next Function End' },
          [']['] = { query = '@class.outer', 'Next Class End' },
        },
        goto_previous_start = {
          ['[m'] = { query = '@function.outer', 'Previous Function Start' },
          ['[['] = { query = '@class.outer', 'Previous Class Start' },
        },
        goto_previous_end = {
          ['[M'] = { query = '@function.outer', 'Previous Function End' },
          ['[]'] = { query = '@class.outer', 'Previous Class End' },
        },
      },
    },
  }

end

return M
