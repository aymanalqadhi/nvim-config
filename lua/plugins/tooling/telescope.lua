return {
  "nvim-telescope/telescope.nvim",

  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },

  config = function()
    require("telescope").setup({
      defaults = {
        winblend = 0,
        prompt_prefix = " ❯ ",
        selection_caret = " ",
        entry_prefix = "   ",
        path_display = { "truncate" },
        borderchars = Void.config.ui.borderchars,
      },
      extensions = {
        wrap_results = true,
        fzf = {},
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    -- setup keymaps
    local tbi = require("telescope.builtin")

    Void.keymap.set({
      -- find
      ["<leader>f"] = {
        f = { tbi.find_files, "find: files" },
        b = { tbi.buffers, "find: buffers" },
        r = { tbi.oldfiles, "find: recent" },
        a = { tbi.autocommands, "find: auto commands" },
        d = { tbi.lsp_document_diagnostics, "find: document diagnostics" },
        D = { tbi.lsp_workspace_diagnostics, "find: workspace diagnostics" },
        h = { tbi.highlights, "find: highlights" },
        w = { tbi.grep_string, "find: selected" },
        m = { tbi.marks, "find: marks" },
        k = { tbi.keymaps, "find: keymaps" },

        ['"'] = { tbi.registers, "find: registers" },
        ["?"] = { tbi.help_tags, "find: help pages" },
      },

      -- git
      ["<leader>g"] = {
        b = { tbi.git_branches, "find: branches" },
        c = { tbi.git_commits, "find: commits" },
        h = { tbi.git_bcommits, "find: file history" },
        s = { tbi.git_status, "find: status" },
        S = { tbi.git_stash, "find: stash" },
      },

      -- misc
      ["<leader>/"] = { tbi.live_grep, "find: live grep" },
      ["<leader>:"] = { tbi.command_history, "find: command history" },
    })

    -- load extensions
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
