return {
  "nvim-telescope/telescope.nvim",

  version = false,
  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local pickers = require("plugins.tooling.telescope.pickers")
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        borderchars = pickers.borderchars.perimeter,
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
            ["<c-j>"] = actions.cycle_history_next,
            ["<c-k>"] = actions.cycle_history_prev,
          },
          n = { q = actions.close },
        },
      },

      pickers = {
        -- find
        find_files = pickers.default(),
        buffers = pickers.dropdown(),
        oldfiles = pickers.dropdown(),
        autocommands = pickers.ivy(),
        diagnostics = pickers.ivy(),
        highlights = pickers.ivy(),
        grep_string = pickers.ivy(),
        marks = pickers.dropdown(),
        keymaps = pickers.dropdown(),
        spell_suggest = pickers.cursor(),

        -- git
        git_files = pickers.default(),
        git_branches = pickers.dropdown(),
        git_commits = pickers.dropdown(),
        git_bcommits = pickers.ivy(),
        git_status = pickers.default(),
        git_stash = pickers.dropdown(),

        -- misc
        live_grep = pickers.ivy(),
        command_history = pickers.dropdown(),
        registers = pickers.cursor(),
        help_tags = pickers.ivy(),
      },

      extensions = {
        wrap_results = true,
        fzf = {},
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(pickers.dropdown()),
        },
      },
    })

    local builtin = require("telescope.builtin")

    -- setup key maps
    void.keymap.set({
      -- general
      { "<leader>fF", builtin.resume, desc = "find: resume" },

      -- find
      { "<leader>ff", builtin.find_files, desc = "find: files" },
      { "<leader>fb", builtin.buffers, desc = "find: buffers" },
      { "<leader>fr", builtin.oldfiles, desc = "find: recent" },
      { "<leader>fa", builtin.autocommands, desc = "find: auto commands" },
      { "<leader>fd", builtin.diagnostics, desc = "find: diagnostics" },
      { "<leader>fh", builtin.highlights, desc = "find: highlights" },
      { "<leader>fw", builtin.grep_string, desc = "find: selected" },
      { "<leader>fm", builtin.marks, desc = "find: marks" },
      { "<leader>fk", builtin.keymaps, desc = "find: keymaps" },
      { "<leader>fs", builtin.spell_suggest, desc = "find: spell suggest" },

      -- git
      { "<leader>fgf", builtin.git_files, desc = "find: branches" },
      { "<leader>fgb", builtin.git_branches, desc = "find: branches" },
      { "<leader>fgc", builtin.git_commits, desc = "find: commits" },
      { "<leader>fgh", builtin.git_bcommits, desc = "find: file history" },
      { "<leader>fgs", builtin.git_status, desc = "find: status" },
      { "<leader>fgS", builtin.git_stash, desc = "find: stash" },

      -- misc
      { "<leader>/", builtin.live_grep, desc = "find: live grep" },
      { "<leader>:", builtin.command_history, desc = "find: command history" },
      { '<leader>"', builtin.registers, desc = "find: registers" },
      { "<leader>?", builtin.help_tags, desc = "find: help pages" },
    })

    -- load extensions
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
