return {
  "lewis6991/gitsigns.nvim",

  cmd = "Gitsigns",
  event = { "BufRead", "BufNewFile" },

  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
  },

  config = function(_, opts)
    require("gitsigns").setup(opts)

    Void.keymap.set({
      -- navigation
      ["]h"] = { "<cmd>Gitsigns next_hunk<cr>", "git: next hunk" },
      ["[h"] = { "<cmd>Gitsigns prev_hunk<cr>", "git: prev hunk" },

      ["<leader>g"] = {
        -- changes
        s = { "<cmd>Gitsigns stage_hunk<cr>", "git: stage hunk", mode = { "n", "v" } },
        u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "git: unstage hunk" },
        r = { "<cmd>Gitsigns reset_hunk<cr>", "git: reset hunk", mode = { "n", "v" } },
        p = { "<cmd>Gitsigns preview_hunk<cr>", "git: preview hunk" },
        S = { "<cmd>Gitsigns stage_buffer<cr>", "git: stage" },
        R = { "<cmd>Gitsigns reset_buffer<cr>", "git: reset" },

        -- diff
        d = { "<cmd>Gitsigns diffthis<cr>", "git: diff" },
        D = { "<cmd>Gitsigns diffthis ~<cr>", "git: diff all" },
        b = { "<cmd>Gitsigns blame_line<cr>", "git: blame" },

        -- toggles
        t = {
          d = { "<cmd>Gitsigns toggle_deleted<cr>", "git: toggle deleted" },
          w = { "<cmd>Gitsigns toggle_word_diff<cr>", "git: toggle word diff" },
          l = { "<cmd>Gitsigns toggle_linehl<cr>", "git: toggle line highlight" },
          L = { "<cmd>Gitsigns toggle_numhl<cr>", "git: toggle number highlight" },
          s = { "<cmd>Gitsigns toggle_signs<cr>", "git: toggle signs" },
        },
      },
    })
  end,
}
