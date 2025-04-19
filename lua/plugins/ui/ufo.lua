return {
  "kevinhwang91/nvim-ufo",

  dependencies = { "kevinhwang91/promise-async" },
  event = "BufRead",

  config = function()
    local ufo = require("ufo")

    ---@diagnostic disable-next-line: missing-fields
    ufo.setup({
      open_fold_hl_timeout = 150,
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
        },
      },
      ---@diagnostic disable-next-line: unused-local
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })

    void.keymap.set({
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
}
