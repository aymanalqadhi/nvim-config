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
        winblend = Void.config.ui.float_winblend,
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

        -- git
        g = {
          b = { tbi.git_branches, "find: branches" },
          c = { tbi.git_commits, "find: commits" },
          h = { tbi.git_bcommits, "find: file history" },
          s = { tbi.git_status, "find: status" },
          S = { tbi.git_stash, "find: stash" },
        },
      },

      -- misc
      ["<leader>/"] = { tbi.live_grep, "find: live grep" },
      ["<leader>:"] = { tbi.command_history, "find: command history" },
      ['<leader>"'] = { tbi.registers, "find: registers" },
      ["<leader>?"] = { tbi.help_tags, "find: help pages" },
    })

    -- load extensions
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
