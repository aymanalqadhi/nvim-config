---@diagnostic disable: missing-fields

local M = {}

-- plugin uri
M.uri = 'nvim-treesitter/nvim-treesitter'

-- plugin dependencies
M.dependencies = {
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/nvim-treesitter-context',
}

-- plugin configuration function
function M.configure()
  local enable = true

  require('nvim-treesitter.configs').setup {
    -- auto install missing parsers
    auto_install = true,

    -- highlighting module
    highlight = {
      enable = enable,
      additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
      enable = false,
      keymaps = {
        -- mappings for incremental selection (visual mappings)
        init_selection = "gnn",    -- maps in normal mode to init the node/scope selection
        node_incremental = "grn",  -- increment to the upper named parent
        scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm"   -- decrement to the previous node
      }
    },

    textobjects = {
      -- syntax-aware textobjects
      enable = enable,
      lsp_interop = {
        enable = true,
      },
      keymaps = {
        -- or you use the queries from supported languages with textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner"
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer"
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer"
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer"
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer"
        }
      },
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        }
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner"
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner"
        }
      }
    }
  }

  require 'treesitter-context'.setup {}
end

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    ['[x'] = { require("treesitter-context").go_to_context, 'Upper Context' }
  })
end

return M
