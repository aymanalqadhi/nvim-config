return {
  "navarasu/onedark.nvim",

  lazy = false,
  priority = 1000,

  config = function()
    local fg = "$fg"
    local fg_border = "$cyan"
    local fg_title = "$black"

    local bg = "$bg1"
    local bg_dark = "$bg0"
    local bg_highlight = "$bg2"
    local bg_title = "$cyan"

    require("onedark").setup({
      style = "dark",
      transparent = true,
      term_colors = true,
      ending_tildes = true,

      code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "none",
        strings = "none",
        variables = "none",
      },

      lualine = {
        transparent = false,
      },

      highlights = {
        -- bqf
        BqfPreviewFloat = { fg = fg, bg = bg_dark },
        BqfPreviewTitle = { fg = fg_title, bg = bg_title },

        -- float
        FloatNormal = { fg = fg, bg = bg_dark },
        FloatBorder = { fg = fg_border, bg = bg_dark },
        FloatTitle = { fg = fg_title, bg = bg_title },

        -- folds
        FoldColumn = { bg = "NONE" },
        Folded = { bg = bg_dark },

        -- lsp highlight
        LspReferenceRead = { bg = bg_highlight },
        LspReferenceWrite = { bg = bg_highlight },
        LspReferenceText = { bg = bg_highlight },

        -- noice/mini
        MsgArea = { fg = fg, bg = bg },

        -- pmenu
        Pmenu = { fg = fg, bg = bg_highlight },

        -- Telescope
        TelescopeNormal = { fg = fg, bg = bg_dark },
        TelescopeBorder = { fg = fg_border, bg = bg_dark },
        TelescopeTitle = { fg = fg_title, bg = bg_title },
        TelescopePromptBorder = { fg = fg_border, bg = bg_dark },
        TelescopeResultsBorder = { fg = fg_border, bg = bg_dark },
        TelescopePreviewBorder = { fg = fg_border, bg = bg_dark },

        -- toggleterm
        ToggleTermFloatNormal = { fg = fg, bg = bg_dark },
        ToggleTermFloatBorder = { fg = fg_border, bg = bg_dark },

        -- treesitter context
        TreesitterContextLineNumber = { bg = bg },

        -- noice
        NoiceCmdlineIconCmdline = { fg = bg_title },
        NoiceCmdlinePopupBorderCmdline = { fg = bg_title },
        NoiceCmdlinePopupTitleCmdline = { fg = fg_title, bg = bg_title },

        NoiceCmdlineIconHelp = { fg = "$blue" },
        NoiceCmdlinePopupBorderHelp = { fg = "$blue" },
        NoiceCmdlinePopupTitleHelp = { fg = fg_title, bg = "$blue" },

        NoiceCmdlineIconLua = { fg = "$purple" },
        NoiceCmdlinePopupBorderLua = { fg = "$purple" },
        NoiceCmdlinePopupTitleLua = { fg = fg_title, bg = "$purple" },

        NoiceCmdlinePrompt = { fg = "$green" },
        NoiceCmdlineIconInput = { fg = "$green" },
        NoiceCmdlinePopupTitleInput = { fg = fg_title, bg = "$green" },
        NoiceCmdlinePopupBorderInput = { fg = "$green" },

        -- nvim-tree
        NvimTreeNormal = { fg = fg, bg = bg_dark },
        NvimTreeNormalFloat = { fg = fg, bg = bg_dark },

        -- cmp/blink
        CmpItemAbbrMatch = { fg = "none", fmt = "bold" },
        BlinkCmpLabelMatch = { fg = "none", fmt = "bold" },
      },

      diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
      },
    })

    require("onedark").load()
  end,

  enabled = void.config.ui.colorscheme == "onedark",
}
