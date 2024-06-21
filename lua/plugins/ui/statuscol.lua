return {
  {
    "luukvbaal/statuscol.nvim",
    branch = "0.10",

    config = function()
      local builtin = require("statuscol.builtin")

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
      local ufo = require("ufo")

      local bc = Void.config.ui.borderchars

      ---@diagnostic disable-next-line: missing-fields
      ufo.setup({
        open_fold_hl_timeout = 150,
        preview = {
          win_config = {
            border = { "", bc.n, "", "", "", bc.s, "", "" },
            winhighlight = "Normal:Folded",
            winblend = Void.config.ui.float_winblend,
          },
        },
        ---@diagnostic disable-next-line: unused-local
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })

      Void.keymap.set({
        { "zR", ufo.openAllFolds,         desc = "fold: open all" },
        { "zM", ufo.closeAllFolds,        desc = "fold: close all" },
        { "zr", ufo.openFoldsExceptKinds, desc = "fold: open except" },
        { "zm", ufo.closeFoldsWith,       desc = "fold: close with" },
        {
          "L",
          function()
            return not ufo.peekFoldedLinesUnderCursor() and "L"
          end,
          desc = "fold: peek",
        }
      })
    end,
  },
}
