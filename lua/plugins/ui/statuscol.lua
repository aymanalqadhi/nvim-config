return {
  {
    "luukvbaal/statuscol.nvim",
    branch = "0.10",

    config = function()
      local builtin = require "statuscol.builtin"

      require("statuscol").setup({
        setopt = true,
        relculright = true,
        segments = {
          {
            sign = {
              name = { ".*" },
              namespace = { ".*" },
              maxwidth = 2,
              colwidth = 2,
              auto = false,
              wrap = true,
            },
            click = "v:lua.ScSa",
          },
          {
            text = { builtin.lnumfunc, " " },
            colwidth = 1,
            click = "v:lua.ScLa",
          },
          {
            sign = {
              name = { "GitSigns*" },
              namespace = { "gitsigns" },
              colwidth = 1,
              fillcharhl = "Nrline",
            },
            click = "v:lua.ScSa",
          },
          {
            text = { builtin.foldfunc, " " },
            hl = "FoldColumn",
            wrap = true,
            colwidth = 1,
            click = "v:lua.ScFa",
          },
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",

    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",

    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require("ufo")

      ---@diagnostic disable-next-line: missing-fields
      ufo.setup({
        open_fold_hl_timeout = 150,
        preview = {
          win_config = {
            border = { "", "─", "", "", "", "─", "", "" },
            winhighlight = "Normal:Folded",
            winblend = 0
          },
        },
        ---@diagnostic disable-next-line: unused-local
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end
      })

      Void.keymap.set({
        z = {
          R = { ufo.openAllFolds, "fold: open all" },
          M = { ufo.closeAllFolds, "fold: close all" },
          r = { ufo.openFoldsExceptKinds, "fold: open except" },
          m = { ufo.closeFoldsWith, "fold: close with" },
        },

        L = { function() return not ufo.peekFoldedLinesUnderCursor() and "L" end, "fold: peek" },

        opts = { noremap = true, silent = true },
      })
    end,
  }
}
