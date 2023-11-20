return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "kristijanhusak/vim-dadbod-completion" },

    opts = function(_, opts)
      require("util").table.safe_extend(opts, {
        sources = {
          { name = "vim-dadbod-completion" },
        },
      })

      return opts
    end,
  },
}
