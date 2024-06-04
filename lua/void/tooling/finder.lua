return {
  "nvim-telescope/telescope.nvim",

  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },

  keys = {
    -- find
    { "<leader>ff",  "<cmd>Telescope find_files<cr>",                         desc = "find: files" },
    { "<leader>fb",  "<cmd>Telescope buffers theme=dropdown<cr>",             desc = "find: buffers" },
    { "<leader>fr",  "<cmd>Telescope oldfiles<cr>",                           desc = "find: recent" },
    { "<leader>fa",  "<cmd>Telescope autocommands<cr>",                       desc = "find: auto commands" },
    { "<leader>fd",  "<cmd>Telescope diagnostics bufnr=0 theme=dropdown<cr>", desc = "find: document diagnostics" },
    { "<leader>fD",  "<cmd>Telescope diagnostics theme=dropdown<cr>",         desc = "find: workspace diagnostics" },
    { "<leader>fh",  "<cmd>Telescope help_tags<cr>",                          desc = "find: help pages" },
    { "<leader>fw",  "<cmd>Telescope grep_string<cr>",                        desc = "find: word" },
    { "<leader>fw",  "<cmd>Telescope grep_string<cr>",                        desc = "find: selection",            mode = "v" },
    { "<leader>fm",  "<cmd>Telescope marks<cr>",                              desc = "find: marks" },
    { '<leader>f"',  "<cmd>Telescope registers<cr>",                          desc = "find: registers" },
    { "<leader>/",   "<cmd>Telescope live_grep<cr>",                          desc = "find: live grep" },
    { "<leader>:",   "<cmd>Telescope command_history<cr>",                    desc = "find: command history" },

    -- git
    { "<leader>fgb", "<cmd>Telescope git_branches theme=dropdown<cr>",        desc = "find: branches" },
    { "<leader>fgc", "<cmd>Telescope git_commits<cr>",                        desc = "find: commits" },
    { "<leader>fgh", "<cmd>Telescope git_bcommits<cr>",                       desc = "find: file history" },
    { "<leader>fgh", "<cmd>Telescope git_bcommits_range<cr>",                 desc = "find: selection history",    mode = "v" },
    { "<leader>fgs", "<cmd>Telescope git_status<cr>",                         desc = "find: status" },
    { "<leader>fgS", "<cmd>Telescope git_stash theme=dropdown<cr>",           desc = "find: stash" },
  },

  config = function()
    require("telescope").setup({
      defaults = {
        winblend = 0,
        prompt_prefix = " ❯ ",
        selection_caret = " ",
        entry_prefix = "   ",
        path_display = { "truncate" },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      extensions = {
        wrap_results = true,
        fzf = {},
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
