return {
  "akinsho/toggleterm.nvim",

  version = "*",
  keys = {
    { "<a-g>", desc = "term: lazygit" },
    { "<c-\\>", desc = "term: toggle" },
    { "<c-t>", desc = "term: toggle float" },
  },

  config = function()
    require("toggleterm").setup({
      open_mapping = "<c-\\>",
      persist_size = false,
      highlights = {
        NormalFloat = { link = "FloatNormal" },
        FloatBorder = { link = "FloatBorder" },
      },
      float_opts = {
        winblend = vim.o.winblend,
        title_pos = "center",
      },
      winbar = {
        enabled = false,
      },
    })

    local function make_term(key, config)
      local term = require("toggleterm.terminal").Terminal:new(config)
      vim.keymap.set("n", key, function()
        term:toggle()
      end)
    end

    -- floating terminal
    make_term("<c-t>", {
      direction = "float",
      display_name = " Terminal ",
    })

    -- lazygit
    make_term("<a-g>", {
      cmd = "lazygit",
      dir = "git_dir",
      display_name = " LazyGit ",
      direction = "float",
      on_open = function(t)
        vim.api.nvim_buf_set_keymap(
          t.bufnr,
          "n",
          "q",
          "<cmd>close<cr>",
          { noremap = true, silent = true }
        )
      end,
    })
  end,
}
