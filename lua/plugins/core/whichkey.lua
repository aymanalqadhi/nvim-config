local M = {}

-- plugin uri
M.uri = 'folke/which-key.nvim'

-- plugin configuration function
function M.configure()

  require('which-key').setup {
    plugins = {
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
    },
    operators = { gc = "Comments" },
    key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
    },
    window = {
      border = "rounded", -- none, single, double, shadow
      margin = { 0, 3, 3, 3 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 50
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 40 }, -- min and max width of the columns
      spacing = 8, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  }

end

return M
