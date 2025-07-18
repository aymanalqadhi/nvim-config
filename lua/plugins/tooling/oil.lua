return {
  "stevearc/oil.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },

  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "oil: view dir" },
  },

  opts = {
    columns = { "icon", "size", "mime" },
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },

      -- toggles
      ["gtt"] = { "actions.toggle_trash", mode = "n" },
      ["gt."] = { "actions.toggle_hidden", mode = "n" },
      ["gtc"] = function()
        local oil = require("oil")
        if not vim.b._oil_columns_hidden then
          oil.set_columns({})
        else
          require("oil").set_columns({ "icon", "size", "mtime" })
        end
        vim.b._oil_columns_hidden = not vim.b._oil_columns_hidden
      end,

      -- actions
      ["<m-q>"] = "actions.close",
      ["<m-p>"] = "actions.preview",
      ["<m-r>"] = "actions.refresh",
      ["<m-s>"] = { "actions.select", opts = { horizontal = true } },
      ["<m-v>"] = { "actions.select", opts = { vertical = true } },
      ["<m-h>"] = "actions.select_split",
      ["<m-t>"] = { "actions.open_terminal", mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },

      -- navigation
      ["<cr>"] = { "actions.select", mode = "n" },
      [">"] = { "actions.select", mode = "n" },
      ["<"] = { "actions.parent", mode = "n" },

      ["<leader>of"] = {
        function()
          require("telescope.builtin").find_files({
            cwd = require("oil").get_current_dir(),
          })
        end,
        mode = "n",
        nowait = true,
        desc = "oil: find files in the current directory",
      },
    },
    view_options = {
      show_hidden = true,
    },
    watch_for_changes = true,
  },
}
