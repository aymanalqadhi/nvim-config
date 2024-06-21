return {
  "akinsho/toggleterm.nvim",

  keys = {
    { "<a-g>",  desc = "term: lazygit" },
    { "<c-\\>", desc = "term: toggle" },
    { "<c-t>",  desc = "term: toggle float" },
  },

  config = function()
    require("toggleterm").setup({
      open_mapping = "<c-\\>",
      persist_size = false,
      shade_terminals = true,
      float_opts = {
        winblend = vim.o.winblend,
        title_pos = "center",
      },
      winbar = {
        enabled = false,
      },
    })

    -- custom terminals
    local term = require("toggleterm.terminal")
    local floating = term.Terminal:new({
      direction = "float",
      display_name = " Terminal ",
    })
    local lazygit = term.Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      display_name = " LazyGit ",
      direction = "float",
      hidden = true,
      esc_esc = false,
      on_open = function(t)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(t.bufnr, "n", "q", "<cmd>close<cr>", {})
      end,
    })

    vim.keymap.set("n", "<a-g>", function() lazygit:toggle() end)
    vim.keymap.set("n", "<c-t>", function() floating:toggle() end)
  end,
}
