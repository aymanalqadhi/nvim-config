return {
  "nvim-telescope/telescope.nvim",

  cmd = "Telescope",

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = vim.fn.executable("make") == 1,
    },
    "spoof/telescope-ui-select.nvim",
  },

  keys = {
    -- find
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    -- git
    { "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "branches" },
    { "<leader>fgc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
    { "<leader>fgh", "<cmd>Telescope git_bcommits<cr>", desc = "file history" },
    { "<leader>fgh", "<cmd>Telescope git_bcommits_range<cr>", desc = "selection history", mode = "v" },
    { "<leader>fgs", "<cmd>Telescope git_status<cr>", desc = "status" },
    { "<leader>fgS", "<cmd>Telescope git_branches<cr>", desc = "stash" },
    -- search
    { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Selection (root dir)", mode = "v" },
  },

  opts = function()
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.providers.telescope").open_with_trouble(...)
    end

    local open_selected_with_trouble = function(...)
      return require("trouble.providers.telescope").open_selected_with_trouble(...)
    end

    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      builtin.find_files({ no_ignore = true, default_text = line })
    end

    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      builtin.find_files({ hidden = true, default_text = line })
    end

    return {
      defaults = {
        winblend = 15,
        prompt_prefix = " ❯ ",
        selection_caret = " ",
        entry_prefix = "   ",
        path_display = { "truncate" },

        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", "target", "build" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        -- get_selection_window = function()
        --   local wins = vim.api.nvim_list_wins()
        --   table.insert(wins, 1, vim.api.nvim_get_current_win())
        --   for _, win in ipairs(wins) do
        --     local buf = vim.api.nvim_win_get_buf(win)
        --     if vim.bo[buf].buftype == "" then
        --       return win
        --     end
        --   end
        --   return 0
        -- end,

        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },

        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_selected_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,

            ["<C-e>"] = actions.preview_scrolling_down,
            ["<C-y>"] = actions.preview_scrolling_up,
            ["<C-k>"] = actions.cycle_history_next,
            ["<C-j>"] = actions.cycle_history_prev,
            ["<c-g>s"] = actions.select_all,
            ["<c-g>a"] = actions.add_selection,
          },
          n = {
            ["q"] = actions.close,
            ["<C-e>"] = actions.results_scrolling_down,
            ["<C-y>"] = actions.results_scrolling_up,
          },
        },
      },

      -- extensions
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },

        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    }
  end,

  config = function(_, opts)
    require("telescope").setup(opts)

    -- load extensions
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
}
