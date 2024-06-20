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
            ["ad"] = "@comment.outer",
            ["id"] = "@comment.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ap"] = "@parameter.outer",
            ["ip"] = "@parameter.inner",
            ["av"] = "@variable.outer",
            ["iv"] = "@variable.inner",
          },

          selection_modes = {
            ["@comment.inner"] = "v",
            ["@comment.outer"] = "V",
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
            ["]d"] = { query = "@comment.outer", desc = "ts: next comment" },
            ["]c"] = { query = "@class.outer", desc = "ts: next class" },
            ["]f"] = { query = "@function.outer", desc = "ts: next function" },
            ["]p"] = { query = "@parameter.outer", desc = "ts: next parameter" },
            ["]v"] = { query = "@variable.outer", desc = "ts: next variable" },
          },

          goto_previous_start = {
            ["[d"] = { query = "@comment.outer", desc = "ts: previous comment" },
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

      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
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
