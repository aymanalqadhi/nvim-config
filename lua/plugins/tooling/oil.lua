return {
  "stevearc/oil.nvim",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "oil: view dir" },
  },

  opts = {
    columns = { "icon", "size" },
    keymaps = {
      ["<c-h>"] = false,
      ["<c-j>"] = false,
      ["<c-k>"] = false,
      ["<c-l>"] = false,
      ["<c-c>"] = false,
      ["<c-p>"] = false,
      ["<c-t>"] = false,

      ["<m-q>"] = "actions.close",
      ["<m-p>"] = "actions.preview",
      ["<m-r>"] = "actions.refresh",
      ["<m-s>"] = { "actions.select", opts = { horizontal = true } },
      ["<m-v>"] = { "actions.select", opts = { vertical = true } },
      ["<m-t>"] = { "actions.select", opts = { tab = true } },

      ["<m-h>"] = "actions.select_split",
    },
    view_options = {
      show_hidden = true,
    },
  }
}
