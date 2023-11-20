return {
  -- autopairs
  {
    "windwp/nvim-autopairs",

    lazy = true,
    event = "InsertEnter",

    opts = {
      -- check_ts = true,
      enable_check_bracket_line = false,
    },

    config = function(_, opts)
      local np = require("nvim-autopairs")

      np.setup(opts)

      -- custom rules
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      --- rust:
      np.add_rules({
        -- raw string
        Rule('r#"', '"#', "rust"):with_pair(cond.not_inside_quote()),
        -- closure
        Rule("|", "|", "rust"):with_move(cond.after_text("|")),
      })
    end,
  },

  -- cmp integration
  {
    "nvim-cmp",
    dependencies = { "windwp/nvim-autopairs" },

    opts = function(_, opts)
      local cmp_ap = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_ap.on_confirm_done())
      return opts
    end,
  },
}
