local M = {}

-- plugin uri
M.uri = 'folke/which-key.nvim'

-- plugin options
M.lazy = true

-- plugin configuration function
function M.configure()

  require('which-key').setup {
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    operators = { gc = "Comments" },
    key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
    },
    window = {
      border = "rounded",
      margin = { 0, 3, 3, 3 },
      padding = { 2, 2, 2, 2 },
      winblend = 50
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 40 },
      spacing = 8,
      align = "center",
    },
    ignore_missing = true,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  }

end

return M
