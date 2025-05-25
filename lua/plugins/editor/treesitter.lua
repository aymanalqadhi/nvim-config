return {
  {
    "nvim-treesitter/nvim-treesitter",

    branch = "main",
    build = ":TSUpdate",
    lazy = false,

    config = function()
      require("nvim-treesitter").setup({
        ensure_install = { "core", "stable" },
      })

      void.event.on("FileType", function(args)
        local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
        if ok and parser then
          vim.treesitter.start(args.buf)
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end, { group = "treesitter" })
    end,

    init = function()
      -- enusure treesitter has a higher prioerity than semantic tokens
      vim.hl.priorities.semantic_tokens = 95
      vim.hl.priorities.treesitter = 100
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

      -- keymaps
      local ts_select = require("nvim-treesitter-textobjects.select")
      local ts_move = require("nvim-treesitter-textobjects.move")
      local ts_swap = require("nvim-treesitter-textobjects.swap")
      local ts_rm = require("nvim-treesitter-textobjects.repeatable_move")

      local function selectfn(textobject)
        return function()
          ts_select.select_textobject(textobject, "textobjects")
        end
      end

      local function movefn(textobject, dir)
        if dir < 0 then
          return function()
            ts_move.goto_previous_start(textobject, "textobjects")
          end
        else
          return function()
            ts_move.goto_next_start(textobject, "textobjects")
          end
        end
      end

      local function swap_fn(textobject, dir)
        if dir < 0 then
          return function()
            ts_swap.swap_previous(textobject)
          end
        else
          return function()
            ts_swap.swap_next(textobject)
          end
        end
      end

      local xo = { "x", "o" }
      local nxo = { "n", "x", "o" }

      void.keymap.set({
        -- select keymaps
        { "ab", selectfn("@block.outer"), desc = "ts(select): around block", mode = xo },
        { "ib", selectfn("@block.inner"), desc = "ts(select): inside block", mode = xo },
        { "ac", selectfn("@class.outer"), desc = "ts(select): around class", mode = xo },
        { "ic", selectfn("@class.inner"), desc = "ts(select): inside class", mode = xo },
        { "af", selectfn("@function.outer"), desc = "ts(select): around function", mode = xo },
        { "if", selectfn("@function.inner"), desc = "ts(select): inside function", mode = xo },
        { "ap", selectfn("@parameter.outer"), desc = "ts(select): around parameter", mode = xo },
        { "ip", selectfn("@parameter.inner"), desc = "ts(select): inside parameter", mode = xo },
        { "av", selectfn("@variable.outer"), desc = "ts(select): around variable", mode = xo },
        { "iv", selectfn("@variable.inner"), desc = "ts(select): inside variable", mode = xo },

        -- move keymaps
        { "]c", movefn("@class.outer", 1), desc = "ts(move): next class", mode = nxo },
        { "[c", movefn("@class.outer", -1), desc = "ts(move): previous class", mode = nxo },
        { "]f", movefn("@function.outer", 1), desc = "ts(move): next function", mode = nxo },
        { "[f", movefn("@function.outer", -1), desc = "ts(move): previous function", mode = nxo },
        { "]p", movefn("@parameter.outer", 1), desc = "ts(move): next parameter", mode = nxo },
        { "[p", movefn("@parameter.outer", -1), desc = "ts(move): previous parameter", mode = nxo },

        -- swap keymaps
        { "<leader>tsf", swap_fn("@function.inner", 1), desc = "ts(swap): next function" },
        { "<leader>tsF", swap_fn("@function.inner", -1), desc = "ts(swap): previous function" },
        { "<leader>tsp", swap_fn("@parameter.inner", 1), desc = "ts(swap): next parameter" },
        { "<leader>tsP", swap_fn("@parameter.inner", -1), desc = "ts(swap): previous parameter" },

        -- repeatable moves
        { ";", ts_rm.repeat_last_move, desc = "ts: repeat last move", mode = nxo },
        {
          ",",
          ts_rm.repeat_last_move_opposite,
          desc = "ts: repeat last move (inverse)",
          mode = nxo,
        },

        -- find and until
        {
          "f",
          ts_rm.builtin_f_expr,
          desc = "ts: find",
          mode = nxo,
          expr = true,
        },
        {
          "F",
          ts_rm.builtin_F_expr,
          desc = "ts: find (backwards)",
          mode = nxo,
          expr = true,
        },
        {
          "t",
          ts_rm.builtin_t_expr,
          desc = "ts: until",
          mode = nxo,
          expr = true,
        },
        {
          "T",
          ts_rm.builtin_T_expr,
          desc = "ts: until (backwards)",
          mode = nxo,
          expr = true,
        },
      })
    end,
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
    },
  },
}
