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

      ---@diagnostic disable-next-line: missing-fields
      require("ufo").setup({
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

      local function set(lhs, rhs, opt)
        vim.keymap.set(opt.mode or "n", lhs, rhs, {
          noremap = true,
          silent = true,
          desc = opt.desc,
        })
      end

      set("zR", require("ufo").openAllFolds, { desc = "fold: open all" })
      set("zM", require("ufo").closeAllFolds, { desc = "fold: close all" })
      set("zr", require("ufo").openFoldsExceptKinds, { desc = "fold: open except" })
      set("zm", require("ufo").closeFoldsWith, { desc = "fold: close with" })
      set("L", function()
        if not require("ufo").peekFoldedLinesUnderCursor() then
          return "L"
        end
      end, { desc = "fold: preview" })
    end,
  }
}
