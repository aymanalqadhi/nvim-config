return {
  "lewis6991/gitsigns.nvim",

  event = { "BufRead", "BufNewFile" },
  keys = {
    -- navigation
    { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next [H]unk" },
    { "[h", "<cmd>Gitsigns next_hunk<cr>", desc = "Previous [H]unk" },

    -- changes
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk", mode = { "n", "v" } },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk", mode = { "n", "v" } },
    { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
    { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Unstage Hunk" },
    { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },

    -- diff
    { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff Buffer" },
    { "<leader>gD", "<cmd>Gitsigns diffthis ~<cr>", desc = "Diff Workspace" },

    -- blame
    { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },

    -- toggles
    { "<leader>gtd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle Deleted" },
    { "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Toggle Word Diff" },
    { "<leader>gtl", "<cmd>Gitsigns toggle_linehl<cr>", desc = "Toggle Line Highlight" },
    { "<leader>gtL", "<cmd>Gitsigns toggle_numhl<cr>", desc = "Toggle Line Number Highlight" },
    { "<leader>gts", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle Signs" },
  },

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
}
