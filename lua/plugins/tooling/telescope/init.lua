return {
  "nvim-telescope/telescope.nvim",

  version = false,
  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local pickers = require("plugins.tooling.telescope.pickers")

    local function action(act)
      return function()
        require("telescope.actions")[act]()
      end
    end

    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
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
        file_ignore_patterns = { ".git/", "node_modules/", "target/" },

        mappings = {
          i = {
            ["<c-j>"] = action("cycle_history_next"),
            ["<c-k>"] = action("cycle_history_prev"),

            -- livegrep args
            ["<c-l>"] = lga_actions.quote_prompt(),
            ["<c-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),

            -- freeze the current list and start a fuzzy search in the frozen list
            ["<C-space>"] = lga_actions.to_fuzzy_refine,
          },
          n = { q = action("close") },
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
        live_grep_args = pickers.ivy(),
        ["ui-select"] = {
          pickers.dropdown(),
        },
      },
    })

    -- load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")

    local builtin = require("telescope.builtin")
    local lga = telescope.extensions.live_grep_args
    local lga_shortcuts = require("telescope-live-grep-args.shortcuts")

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
      { "<leader>fm", builtin.marks, desc = "find: marks" },
      { "<leader>fk", builtin.keymaps, desc = "find: keymaps" },
      { "<leader>fs", builtin.spell_suggest, desc = "find: spell suggest" },
      { "<leader>fw", builtin.grep_string, desc = "find: selected" },
      {
        "<leader>/",
        lga_shortcuts.grep_visual_selection,
        desc = "find: live grep",
        mode = { "v" },
      },
      { "<leader>/", lga.live_grep_args, desc = "find: live grep" },

      -- git
      { "<leader>fgf", builtin.git_files, desc = "find: branches" },
      { "<leader>fgb", builtin.git_branches, desc = "find: branches" },
      { "<leader>fgc", builtin.git_commits, desc = "find: commits" },
      { "<leader>fgh", builtin.git_bcommits, desc = "find: file history" },
      { "<leader>fgs", builtin.git_status, desc = "find: status" },
      { "<leader>fgS", builtin.git_stash, desc = "find: stash" },

      -- misc
      { "<leader>:", builtin.command_history, desc = "find: command history" },
      { '<leader>"', builtin.registers, desc = "find: registers" },
      { "<leader>?", builtin.help_tags, desc = "find: help pages" },
    })
  end,
}
