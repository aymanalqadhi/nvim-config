local M = {}

-- plugin uri
M.uri = 'nvim-treesitter/nvim-treesitter'

-- plugin dependencies
M.dependencies = {
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
          ['af'] = { query = '@function.outer', 'A Function' },
          ['if'] = { query = '@function.inner', 'In Function' },
          ['ac'] = { query = '@class.outer', 'A Class' },
          ['ic'] = { query = '@class.in', 'In Class' },
        },
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = '<c-v>',
        },
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = { query = "@class.outer", desc = "Next class start" },
          ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  }

end

return M
