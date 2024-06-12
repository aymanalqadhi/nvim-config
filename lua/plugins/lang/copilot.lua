return {
  "zbirenbaum/copilot.lua",

  dependencies = {
    "hrsh7th/nvim-cmp",
    "zbirenbaum/copilot-cmp",
  },

  cmd = "Copilot",

  opts = {
    panel = { enabled = false, },
    suggestion = { enabled = false },
    filetypes = {
      sh = function()
        local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        return not string.match(filename, "^%.env.*")
      end,
    },
  },

  config = function(_, opts)
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "DiagnosticHint" })

    require("copilot").setup(opts)
    require("copilot_cmp").setup()
  end
}
