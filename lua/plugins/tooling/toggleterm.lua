return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-\>]],
      winbar = {
        enabled = false,
      },
      float_opts = {
        winblend = 15,
      },
      -- highlights = {
      --   Normal = {
      --     guibg = "#242933",
      --   },
      --   NormalFloat = {
      --     guibg = "#242933",
      --   },
      --   FloatBorder = {
      --     guibg = "#242933",
      --   },
      -- },
    })

    -- custom terminals
    local term = require("toggleterm.terminal")
    local floating = term.Terminal:new({ direction = "float" })
    local lazygit = term.Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      hidden = true,
      esc_esc = false,
      on_open = function(t)
        vim.cmd("startinsert!")
        -- close with `q`
        vim.api.nvim_buf_set_keymap(t.bufnr, "n", "q", "<cmd>close<CR>", {})
        -- unmap `esc` key
        -- vim.vim.api.nvim_buf_del_keymap(t.bufnr, "t", "<esc>")
      end,
    })

    local set = require("util.keymap").set

    -- lazygit
    set("n", "<A-g>", function()
      lazygit:toggle()
    end)
    set("n", "<C-t>", function()
      floating:toggle()
    end)
  end,
}
