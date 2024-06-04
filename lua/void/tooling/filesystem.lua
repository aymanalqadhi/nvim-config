return {
  "stevearc/oil.nvim",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "fs: view dir" },
  },

  opts = {
    columns = { "icon" },
    keymaps = {
      ["<c-h>"] = false,
      ["<m-h>"] = "actions.select_split",
    },
    view_options = {
      show_hidden = true,
    },
  }
}
