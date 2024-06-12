return {
  {
    "nvim-treesitter/nvim-treesitter",

    branch = "main",
    build = ":TSUpdate",
    lazy = false,

    opts = {
      legacy_syntax = {},
      ensure_install = { "core", "stable" },
      auto_install = true,
    },

    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      -- auto-enable features
      local augroup = vim.api.nvim_create_augroup("void.treesitter", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        callback = function(args)
          local bufnr = args.buf
          local ft = vim.bo[bufnr].filetype

          if opts.legacy_syntax[ft] then
            vim.bo[bufnr].syntax = "on"
          end

          if pcall(vim.treesitter.start) then
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",

    branch = "main",
    event = "VeryLazy",

    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
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
        move = {
          set_jumps = true,
        },
      })

      local set = vim.keymap.set

      local select = require("nvim-treesitter-textobjects.select")
      local function map_select(lhs, cap)
        set({ "x", "o" }, lhs, function()
          select.select_textobject(cap, "textobjects")
        end, { desc = "ts: select " .. cap })
      end

      map_select("ad", "@comment.outer")
      map_select("id", "@comment.inner")
      map_select("av", "@variable.outer")
      map_select("iv", "@variable.inner")
      map_select("ap", "@parameter.outer")
      map_select("ip", "@parameter.inner")
      map_select("af", "@function.outer")
      map_select("if", "@function.inner")
      map_select("ac", "@class.outer")
      map_select("ic", "@class.inner")

      local swap = require("nvim-treesitter-textobjects.swap")
      local function map_swap_next(lhs, cap)
        set("n", lhs, swap.swap_next(cap), { desc = "ts: swap next " .. cap })
      end
      local function map_swap_prev(lhs, cap)
        set("n", lhs, swap.swap_previous(cap), { desc = "ts: swap previous " .. cap })
      end

      map_swap_next("<leader>tsv", "@variable.inner")
      map_swap_next("<leader>tsV", "@variable.outer")
      map_swap_prev("<leader>tSv", "@variable.inner")
      map_swap_prev("<leader>tSV", "@variable.outer")
      map_swap_next("<leader>tsp", "@parameter.inner")
      map_swap_next("<leader>tsP", "@parameter.outer")
      map_swap_prev("<leader>tSp", "@parameter.inner")
      map_swap_prev("<leader>tSP", "@parameter.outer")

      local move = require("nvim-treesitter-textobjects.move")
      local function map_move_next(lhs, cap)
        set({ "n", "x", "o" }, lhs, function()
          move.goto_next_start(cap, "textobjects")
        end, { desc = "ts: next " .. cap })
      end
      local function map_move_prev(lhs, cap)
        set({ "n", "x", "o" }, lhs, function()
          move.goto_previous_start(cap, "textobjects")
        end, { desc = "ts: prev " .. cap })
      end

      map_move_next("]v", "@variable.inner")
      map_move_prev("[v", "@variable.inner")
      map_move_next("]p", "@parameter.inner")
      map_move_prev("[p", "@parameter.inner")
      map_move_next("]f", "@function.outer")
      map_move_prev("[f", "@function.outer")
      map_move_next("]c", "@class.outer")
      map_move_prev("[c", "@class.outer")

      local ts_rm = require "nvim-treesitter-textobjects.repeatable_move"

      set({ "n", "x", "o" }, ";", ts_rm.repeat_last_move_next)
      set({ "n", "x", "o" }, ",", ts_rm.repeat_last_move_previous)
      set({ "n", "x", "o" }, "f", ts_rm.builtin_f_expr, { expr = true })
      set({ "n", "x", "o" }, "F", ts_rm.builtin_F_expr, { expr = true })
      set({ "n", "x", "o" }, "t", ts_rm.builtin_t_expr, { expr = true })
      set({ "n", "x", "o" }, "T", ts_rm.builtin_T_expr, { expr = true })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "UIEnter",

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
