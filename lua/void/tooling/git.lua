return {
  "lewis6991/gitsigns.nvim",

  event = { "BufRead", "BufNewFile" },
  keys = {
    -- navigation
    { "]h",          "<cmd>Gitsigns next_hunk<cr>",        desc = "git: next hunk" },
    { "[h",          "<cmd>Gitsigns next_hunk<cr>",        desc = "git: prev hunk" },

    -- changes
    { "<leader>gs",  "<cmd>Gitsigns stage_hunk<cr>",       desc = "git: stage hunk",             mode = { "n", "v" } },
    { "<leader>gu",  "<cmd>Gitsigns undo_stage_hunk<cr>",  desc = "git: unstage hunk" },
    { "<leader>gr",  "<cmd>Gitsigns reset_hunk<cr>",       desc = "git: reset hunk",             mode = { "n", "v" } },
    { "<leader>gp",  "<cmd>Gitsigns preview_hunk<cr>",     desc = "git: preview hunk" },
    { "<leader>gS",  "<cmd>Gitsigns stage_buffer<cr>",     desc = "git: stage" },
    { "<leader>gR",  "<cmd>Gitsigns reset_buffer<cr>",     desc = "git: reset" },

    -- diff
    { "<leader>gd",  "<cmd>Gitsigns diffthis<cr>",         desc = "git: diff" },
    { "<leader>gD",  "<cmd>Gitsigns diffthis ~<cr>",       desc = "git: diff all" },

    -- blame
    { "<leader>gb",  "<cmd>Gitsigns blame_line<cr>",       desc = "git: blame" },

    -- toggles
    { "<leader>gtd", "<cmd>Gitsigns toggle_deleted<cr>",   desc = "git: toggle deleted" },
    { "<leader>gtw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "git: toggle word diff" },
    { "<leader>gtl", "<cmd>Gitsigns toggle_linehl<cr>",    desc = "git: toggle line highlight" },
    { "<leader>gtL", "<cmd>Gitsigns toggle_numhl<cr>",     desc = "git: toggle number highlight" },
    { "<leader>gts", "<cmd>Gitsigns toggle_signs<cr>",     desc = "git: toggle signs" },
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
