return {
  {
    "navarasu/onedark.nvim",

    lazy = false,
    priority = 1000,

    config = function()
      local fg = "$fg"
      local fg_dark = "$grey"
      local fg_border = "$cyan"
      local fg_title = "$black"

      local bg = "$bg1"
      local bg_dark = "$bg0"
      local bg_highlight = "$bg2"
      local bg_title = "$cyan"

      require("onedark").setup({
        style         = "dark",
        transparent   = true,
        term_colors   = true,
        ending_tildes = true,

        code_style    = {
          comments = "italic",
          keywords = "bold",
          functions = "none",
          strings = "none",
          variables = "none",
        },

        lualine       = {
          transparent = false,
        },

        highlights    = {
          -- bqf
          BqfPreviewFloat             = { fg = fg, bg = bg_dark },
          BqfPreviewTitle             = { fg = fg_title, bg = bg_title },

          -- float
          FloatNormal                 = { fg = fg, bg = bg_dark },
          FloatBorder                 = { fg = fg_border, bg = bg_dark },
          Title                       = { fg = fg_title, bg = bg_title },

          -- folds
          FoldColumn                  = { bg = "NONE" },
          Folded                      = { bg = bg_dark },

          -- lsp highlight
          LspReferenceRead            = { bg = bg_highlight },
          LspReferenceWrite           = { bg = bg_highlight },
          LspReferenceText            = { bg = "NONE", fmt = "underline" },

          -- noice/mini
          MsgArea                     = { fg = fg, bg = bg },

          -- pmenu
          Pmenu                       = { fg = fg, bg = bg_highlight },

          -- Telescope
          TelescopeNormal             = { fg = fg, bg = bg_dark },
          TelescopeBorder             = { fg = fg_border, bg = bg_dark },
          TelescopeTitle              = { fg = fg_title, bg = bg_title },
          TelescopePromptBorder       = { fg = fg_border, bg = bg_dark },
          TelescopeResultsBorder      = { fg = fg_border, bg = bg_dark },
          TelescopePreviewBorder      = { fg = fg_border, bg = bg_dark },

          -- toggleterm
          ToggleTermFloatNormal       = { fg = fg, bg = bg_dark },
          ToggleTermFloatBorder       = { fg = fg_border, bg = bg_dark },

          -- treesitter context
          TreesitterContextLineNumber = { fg = fg_dark, bg = bg },
          -- cmp
          CmpItemKindCopilot          = { fg = "$purple" }
        },

        diagnostics   = {
          darker = true,
          undercurl = true,
          background = true,
        },
      })

      require("onedark").load()
    end,
  }
}
