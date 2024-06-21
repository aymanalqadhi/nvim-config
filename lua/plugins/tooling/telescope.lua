return {
  "nvim-telescope/telescope.nvim",

  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },

  config = function()
    local ui = Void.config.ui
    local bc = ui.borderchars

    local main_bc = { bc.n, bc.e, bc.s, bc.w, bc.nw, bc.ne, bc.se, bc.sw }
    local drop_bc = {
      prompt  = { bc.n, bc.e, " ", bc.w, bc.nw, bc.ne, bc.e, bc.w },
      results = { bc.n, bc.e, bc.s, bc.w, bc.wm, bc.em, bc.se, bc.sw },
      preview = { bc.nc, bc.e, bc.s, bc.w, bc.nw, bc.ne, bc.se, bc.sw }
    }

    require("telescope").setup({
      defaults = {
        prompt_prefix = " ❯ ",
        selection_caret = " ",
        entry_prefix = "   ",
        path_display = { "truncate" },
        borderchars = main_bc,
      },
      extensions = {
        wrap_results = true,
        fzf = {},
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            borderchars = drop_bc,
          }),
        },
      },
    })

    -- setup key maps
    local tbi = require("telescope.builtin")

    local function dd(fn)
      return function()
        fn(require("telescope.themes").get_dropdown({ borderchars = drop_bc }))
      end
    end

    Void.keymap.set({
      -- find
      { "<leader>ff",  tbi.find_files,        desc = "find: files" },
      { "<leader>fb",  tbi.find_files,        desc = "find: buffers" },
      { "<leader>fr",  tbi.oldfiles,          desc = "find: recent" },
      { "<leader>fa",  tbi.autocommands,      desc = "find: auto commands" },
      { "<leader>fd",  tbi.diagnostics,       desc = "find: diagnostics" },
      { "<leader>fh",  tbi.highlights,        desc = "find: highlights" },
      { "<leader>fw",  tbi.grep_string,       desc = "find: selected" },
      { "<leader>fm",  tbi.marks,             desc = "find: marks" },
      { "<leader>fk",  tbi.keymaps,           desc = "find: keymaps" },
      { "<leader>fs",  dd(tbi.spell_suggest), desc = "find: spell suggest" },

      -- git
      { "<leader>fgb", dd(tbi.git_branches),  desc = "find: branches" },
      { "<leader>fgc", tbi.git_commits,       desc = "find: commits" },
      { "<leader>fgh", tbi.git_bcommits,      desc = "find: file history" },
      { "<leader>fgs", tbi.git_status,        desc = "find: status" },
      { "<leader>fgS", dd(tbi.git_stash),     desc = "find: stash" },

      -- misc
      { "<leader>/",   tbi.live_grep,         desc = "find: live grep" },
      { "<leader>:",   tbi.command_history,   desc = "find: command history" },
      { '<leader>"',   tbi.registers,         desc = "find: registers" },
      { "<leader>?",   tbi.help_tags,         desc = "find: help pages" },
    })

    -- load extensions
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
