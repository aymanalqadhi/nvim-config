return {
  {
    "nvim-treesitter/nvim-treesitter",

    branch = "main",
    build = ":TSUpdate",
    event = "VeryLazy",

    config = function()
      require("nvim-treesitter").setup({
        sync_install = false,
        auto_install = true,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",

    branch = "main",
    event = "VeryLazy",

    config = function()
      require("nvim-treesitter-textobjects").setup({
        selection_modes = {
          ["@variable.outer"] = "v",
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "V",
        },
        move = {
          set_jumps = true,
        },
      })

      local set = vim.keymap.set

      local select = require("nvim-treesitter-textobjects.select")
      local function map_select(lhs, cap)
        set({ "x", "o" }, lhs, function() select.select_textobject(cap, "textobjects") end)
      end

      map_select("af", "@function.outer")
      map_select("if", "@function.inner")
      map_select("ac", "@class.outer")
      map_select("ic", "@class.inner")
      map_select("ap", "@parameter.outer")
      map_select("ip", "@parameter.inner")

      local swap = require("nvim-treesitter-textobjects.swap")
      local function map_swap_next(lhs, cap) set("n", lhs, swap.swap_next(cap)) end
      local function map_swap_prev(lhs, cap) set("n", lhs, swap.swap_previous(cap)) end

      map_swap_next("<leader>tsp", "@parameter.inner")
      map_swap_prev("<leader>tSp", "@parameter.inner")

      local move = require("nvim-treesitter-textobjects.move")
      local function map_move_next(lhs, cap)
        local opt = { desc = "move: next " .. cap }
        set({ "n", "x", "o" }, lhs, function() move.goto_next_start(cap, "textobjects") end, opt)
      end
      local function map_move_prev(lhs, cap)
        local opt = { desc = "move: prev " .. cap }
        set({ "n", "x", "o" }, lhs, function() move.goto_previous_start(cap, "textobjects") end, opt)
      end

      map_move_next("]p", "@parameter.inner")
      map_move_prev("[p", "@parameter.inner")
      map_move_next("]f", "@function.outer")
      map_move_prev("[f", "@function.outer")
      map_move_next("]c", "@class.outer")
      map_move_prev("[c", "@class.outer")

      local ts_rm = require "nvim-treesitter-textobjects.repeatable_move"
      set({ "n", "x", "o" }, ";", ts_rm.repeat_last_move)
      set({ "n", "x", "o" }, ",", ts_rm.repeat_last_move_opposite)
      set({ "n", "x", "o" }, "f", ts_rm.builtin_f_expr)
      set({ "n", "x", "o" }, "F", ts_rm.builtin_F_expr)
      set({ "n", "x", "o" }, "t", ts_rm.builtin_t_expr)
      set({ "n", "x", "o" }, "T", ts_rm.builtin_T_expr)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "UIEnter",

    opts = {
      enable = true,
      max_lines = 12,
      line_numbers = true,
      multiline_threshold = 4,
    }
  },
  {
    "andymass/vim-matchup",
    event = "VeryLazy",

    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
}
