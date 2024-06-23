return {
  {
    "nvim-treesitter/nvim-treesitter",

    branch = "master",
    build = ":TSUpdate",
    event = "VeryLazy",

    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

    opts = {
      auto_install = true,
      ensure_installed = {
        "c",
        "diff",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "vimdoc",
      },

      -- better syntax eighlighting
      highlight = { enable = true },

      -- better indentation
      indent = { enable = true },

      -- context-aware selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          scope_incremental = "<c-cr>",
          node_decremental = "<bs>",
        },
      },

      -- more advanced text-objects
      textobjects = {
        -- selection
        select = {
          enable = true,
          lookahead = true,

          keymaps = {
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            ["av"] = "@variable.outer",
            ["iv"] = "@variable.inner",
          },

          selection_modes = {
            ["@variable.inner"] = "v",
            ["@variable.outer"] = "v",
            ["@parameter.inner"] = "v",
            ["@parameter.outer"] = "v",
            ["@function.inner"] = "v",
            ["@function.outer"] = "V",
            ["@class.inner"] = "v",
            ["@class.outer"] = "V",
          },
        },

        -- element navigation
        move = {
          enable = true,
          set_jumps = true,

          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "ts: next class" },
            ["]f"] = { query = "@function.outer", desc = "ts: next function" },
            ["]p"] = { query = "@parameter.outer", desc = "ts: next parameter" },
            ["]v"] = { query = "@variable.outer", desc = "ts: next variable" },
          },

          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "ts: previous class" },
            ["[f"] = { query = "@function.outer", desc = "ts: previous function" },
            ["[p"] = { query = "@parameter.outer", desc = "ts: previous parameter" },
            ["[v"] = { query = "@variable.outer", desc = "ts: previous variable" },
          },
        },

        -- element swapping
        swap = {
          enable = true,
          swap_next = {
            ["<leader>tsf"] = { query = "@function.inner", desc = "ts: swap next function" },
            ["<leader>tsp"] = { query = "@parameter.inner", desc = "ts: swap next parameter" },
            ["<leader>tsv"] = { query = "@variable.inner", desc = "ts: swap next variable" },
          },

          swap_previous = {
            ["<leader>tsF"] = { query = "@function.inner", desc = "ts: swap previous function" },
            ["<leader>tsP"] = { query = "@parameter.inner", desc = "ts: swap previous parameter" },
            ["<leader>tsV"] = { query = "@variable.inner", desc = "ts: swap previous variable" },
          },
        },

        -- lsp enhancement
        lsp_interop = {
          enable = true,
          floating_preview_opts = {},
          peek_definition_code = {
            ["gpf"] = { query = "@function.outer", desc = "ts: peek function definition" },
            ["gpF"] = { query = "@class.outer", desc = "ts: peek function definition in class" },
          },
        },
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      local mode = { "n", "x", "o" }
      local ts_rm = require("nvim-treesitter.textobjects.repeatable_move")

      Void.keymap.set({
        -- repeatable moves
        { ";", ts_rm.repeat_last_move,          desc = "ts: repeat last move",           mode = mode },
        { ",", ts_rm.repeat_last_move_opposite, desc = "ts: repeat last move (inverse)", mode = mode },

        -- find and until
        { "f", ts_rm.builtin_f_expr,            desc = "ts: find",                       expr = true, mode = mode },
        { "F", ts_rm.builtin_F_expr,            desc = "ts: find (backwards)",           expr = true, mode = mode },
        { "t", ts_rm.builtin_t_expr,            desc = "ts: until",                      expr = true, mode = mode },
        { "T", ts_rm.builtin_T_expr,            desc = "ts: until (backwards)",          expr = true, mode = mode },
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",

    event = "VeryLazy",
    keys = {
      { "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "ts: toggle context" },
    },

    opts = {
      enable = true,
      max_lines = 12,
      line_numbers = true,
      multiline_threshold = 4,
    }
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },

    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
}
