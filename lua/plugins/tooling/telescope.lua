local borderchars = {
  single = {
    perimeter = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    divider   = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
  }
}


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
    local bc = borderchars[ui.border]

    local pickers = {
      dropdown = {
        theme = "dropdown",
        borderchars = {
          prompt = bc.perimeter,
          results = bc.divider,
          preview = bc.perimeter,
        },
      },
      cursor = {
        theme = "cursor",
        borderchars = {
          prompt = bc.perimeter,
          results = bc.divider,
        },
      },
      ivy = {
        theme = "ivy",
        borderchars = {
          preview = bc.perimeter,
        },
      },
    }

    local act = require("telescope.actions")
    local tbi = require("telescope.builtin")

    require("telescope").setup({
      defaults = {
        borderchars = bc.perimeter,
        entry_prefix = "   ",
        layout_strategy = "horizontal",
        prompt_prefix = " ❯ ",
        selection_caret = " ",

        path_display = { "truncate" },
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        file_ignore_patterns = { ".git/", "node_modules/", "build/", "target/" },

        mappings = {
          i = {
            ["<c-j>"] = act.cycle_history_next,
            ["<c-k>"] = act.cycle_history_prev,
            ["<c-q>"] = act.close,
          },
          n = {
            ["<c-q>"] = act.close,
          },
        },
      },

      pickers = {
        -- find
        find_files      = {},
        buffers         = pickers.dropdown,
        oldfiles        = pickers.dropdown,
        autocommands    = pickers.ivy,
        diagnostics     = pickers.ivy,
        highlights      = pickers.ivy,
        grep_string     = pickers.ivy,
        marks           = pickers.dropdown,
        keymaps         = pickers.dropdown,
        spell_suggest   = pickers.cursor,

        -- git
        git_files       = pickers.default,
        git_branches    = pickers.dropdown,
        git_commits     = pickers.dropdown,
        git_bcommits    = pickers.ivy,
        git_status      = pickers.default,
        git_stash       = pickers.dropdown,

        -- misc
        live_grep       = pickers.ivy,
        command_history = pickers.dropdown,
        registers       = pickers.cursor,
        help_tags       = pickers.ivy,
      },
      extensions = {
        wrap_results = true,
        fzf = {},
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(pickers.dropdown),
        },
      },
    })

    -- setup key maps
    Void.keymap.set({
      -- general
      { "<leader>fF",  tbi.resume,          desc = "find: resume" },

      -- find
      { "<leader>ff",  tbi.find_files,      desc = "find: files" },
      { "<leader>fb",  tbi.buffers,         desc = "find: buffers" },
      { "<leader>fr",  tbi.oldfiles,        desc = "find: recent" },
      { "<leader>fa",  tbi.autocommands,    desc = "find: auto commands" },
      { "<leader>fd",  tbi.diagnostics,     desc = "find: diagnostics" },
      { "<leader>fh",  tbi.highlights,      desc = "find: highlights" },
      { "<leader>fw",  tbi.grep_string,     desc = "find: selected" },
      { "<leader>fm",  tbi.marks,           desc = "find: marks" },
      { "<leader>fk",  tbi.keymaps,         desc = "find: keymaps" },
      { "<leader>fs",  tbi.spell_suggest,   desc = "find: spell suggest" },

      -- git
      { "<leader>fgf", tbi.git_files,       desc = "find: branches" },
      { "<leader>fgb", tbi.git_branches,    desc = "find: branches" },
      { "<leader>fgc", tbi.git_commits,     desc = "find: commits" },
      { "<leader>fgh", tbi.git_bcommits,    desc = "find: file history" },
      { "<leader>fgs", tbi.git_status,      desc = "find: status" },
      { "<leader>fgS", tbi.git_stash,       desc = "find: stash" },

      -- misc
      { "<leader>/",   tbi.live_grep,       desc = "find: live grep" },
      { "<leader>:",   tbi.command_history, desc = "find: command history" },
      { '<leader>"',   tbi.registers,       desc = "find: registers" },
      { "<leader>?",   tbi.help_tags,       desc = "find: help pages" },
    })

    -- load extensions
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
