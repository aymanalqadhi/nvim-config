return {
  "catppuccin/nvim",

  -- lazy = true,
  name = "catppuccin",

  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },

    transparent_background = true,
    show_end_of_buffer = true,
    term_colors = true,

    integrations = {
      alpha = true,
      cmp = true,
      flash = true,
      gitsigns = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      lsp_trouble = true,
      mason = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      noice = true,
      notify = true,
      neotree = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      which_key = true,
    },
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,

  cond = function()
    local cfg = require("config").current
    return cfg and cfg.colorscheme == "catppuccin"
  end,
}
