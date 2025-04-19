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
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      void.keymap.buf_set(bufnr, {
        -- navigation
        { "]h",          gs.next_hunk,        desc = "git: next hunk" },
        { "[h",          gs.prev_hunk,        desc = "git: prev hunk" },

        -- changes
        { "<leader>gs",  gs.stage_hunk,       desc = "git: stage hunk",             mode = { "n", "v" } },
        { "<leader>gu",  gs.undo_stage_hunk,  desc = "git: unstage hunk" },
        { "<leader>gr",  gs.reset_hunk,       desc = "git: reset hunk",             mode = { "n", "v" } },
        { "<leader>gp",  gs.preview_hunk,     desc = "git: preview hunk" },
        { "<leader>gS",  gs.stage_buffer,     desc = "git: stage" },
        { "<leader>gR",  gs.reset_buffer,     desc = "git: reset" },

        -- diff
        { "<leader>gd",  gs.diffthis,         desc = "git: diff" },
        { "<leader>gD",  gs.diffthis,         desc = "git: diff all" },
        { "<leader>gb",  gs.blame_line,       desc = "git: blame" },

        -- toggles
        { "<leader>gtd", gs.toggle_deleted,   desc = "git: toggle deleted" },
        { "<leader>gtw", gs.toggle_word_diff, desc = "git: toggle word diff" },
        { "<leader>gtl", gs.toggle_linehl,    desc = "git: toggle line highlight" },
        { "<leader>gTL", gs.toggle_numhl,     desc = "git: toggle number highlight" },
        { "<leader>gts", gs.toggle_signs,     desc = "git: toggle signs" },
      })
    end
  },
}
