return {
  "gbprod/yanky.nvim",

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  keys = {
    {
      "<leader>p",
      "<cmd>YankyRingHistory<cr>",
      mode = { "n", "x" },
      desc = "yanky: Open Yank History",
    },
    {
      "y",
      "<Plug>(YankyYank)",
      mode = { "n", "x" },
      desc = "yanky: Yank text",
    },
    {
      "p",
      "<Plug>(YankyPutAfter)",
      mode = { "n", "x" },
      desc = "yanky: Put yanked text after cursor",
    },
    {
      "P",
      "<Plug>(YankyPutBefore)",
      mode = { "n", "x" },
      desc = "yanky: Put yanked text before cursor",
    },
    {
      "gp",
      "<Plug>(YankyGPutAfter)",
      mode = { "n", "x" },
      desc = "yanky: Put yanked text after selection",
    },
    {
      "gP",
      "<Plug>(YankyGPutBefore)",
      mode = { "n", "x" },
      desc = "yanky: Put yanked text before selection",
    },
    {
      "<c-p>",
      "<Plug>(YankyPreviousEntry)",
      desc = "yanky: Select previous entry through yank history",
    },
    {
      "<c-n>",
      "<Plug>(YankyNextEntry)",
      desc = "yanky: Select next entry through yank history",
    },
    {
      "]p",
      "<Plug>(YankyPutIndentAfterLinewise)",
      desc = "yanky: Put indented after cursor (linewise)",
    },
    {
      "[p",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "yanky: Put indented before cursor (linewise)",
    },
    {
      "]P",
      "<Plug>(YankyPutIndentAfterLinewise)",
      desc = "yanky: Put indented after cursor (linewise)",
    },
    {
      "[P",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      desc = "yanky: Put indented before cursor (linewise)",
    },
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "yanky: Put and indent right" },
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)",  desc = "yanky: Put and indent left" },
    {
      ">P",
      "<Plug>(YankyPutIndentBeforeShiftRight)",
      desc = "yanky: Put before and indent right",
    },
    {
      "<P",
      "<Plug>(YankyPutIndentBeforeShiftLeft)",
      desc = "yanky: Put before and indent left",
    },
    {
      "=p",
      "<Plug>(YankyPutAfterFilter)",
      desc = "yanky: Put after applying a filter",
    },
    {
      "=P",
      "<Plug>(YankyPutBeforeFilter)",
      desc = "yanky: Put before applying a filter",
    },
  },

  opts = {
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 300,
    },
  },

  config = function(_, opts)
    require("yanky").setup(opts)

    -- telescope integration
    require("telescope").load_extension("yank_history")
    void.keymap.set({
      {
        "<leader>fy",
        function()
          require("telescope").extensions.yank_history.yank_history()
        end,
        desc = "telescope: browse yank history",
      },
    })

    -- link `YankPut` and `YankyYanked` to `Visual`
    vim.api.nvim_set_hl(0, "YankyPut", { link = "Visual" })
    vim.api.nvim_set_hl(0, "YankyYanked", { link = "Visual" })
  end,
}
