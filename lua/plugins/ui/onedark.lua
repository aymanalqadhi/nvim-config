return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,

  opts = {
    style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
    -- cmp_itemkind_reverse = true, -- reverse item kind highlights in cmp menu

    code_style = {
      comments = "italic",
      keywords = "bold",
      functions = "none",
      strings = "none",
      variables = "none",
    },

    -- Lualine options --
    lualine = {
      transparent = false, -- lualine center bar transparency
    },

    -- highlight overrides
    highlights = {
      -- disable injected highlights for rust strings
      -- ["@lsp.type.string.rust"] = {},
    },
  },

  config = function(_, opts)
    require("onedark").setup(opts)
    require("onedark").load()
  end,

  cond = function()
    return require("config").current.colorscheme == "onedark"
  end,
}
