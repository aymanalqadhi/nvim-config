return {
  "ray-x/go.nvim",

  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
  },

  ft = { "go", "gomod", "gowork", "gosum" },
  build = ':lua require("go.install").update_all_sync()',

  config = function()
    require("go").setup({
      max_line_len = 100,

      gofmt = "golines",
      goimports = "golines",

      lsp_cfg = false,
      lsp_keymaps = false,
      lsp_gofumpt = true,
      dap_debug_keymap = false,
      diagnostic = false,
      textobjects = false,

      -- trouble = true,
      -- luasnip = true,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern  = { "go", "gomod", "gowork", "gosum" },
      group    = vim.api.nvim_create_augroup("void-go", { clear = true }),
      callback = function(args)
        require("void.core.keymap").set({
          ["<localleader>g"] = {
            r = { "<cmd>GoRun<cr>", "go: run" },
          },
          opts = { buffer = args.bufnr },
        })
      end,
    })
  end,
}
