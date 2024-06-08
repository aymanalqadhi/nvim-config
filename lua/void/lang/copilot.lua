return {
  {
    "zbirenbaum/copilot.lua",

    event = { "InsertEnter" },

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
  },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "zbirenbaum/copilot-cmp", opts = {} },
    opts = function(_, opts)
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { link = "DiagnosticHint" })

      table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
      table.insert(opts.sorting.comparators, 1, require("copilot_cmp.comparators").prioritize)

      return opts
    end,
  },
}
