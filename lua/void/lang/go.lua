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

      diagnostics = {
        hdlr = true,
      },

      trouble = true,
      luasnip = true,
    })

    vim.api.nvim_create_augroup("void-rust", { clear = true })
    vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
      pattern = { "go", "gomod", "gowork", "gosum" },
      callback = function(args)
        local bufnr = args.bufnr

        local function set(lhs, rhs, opt)
          vim.keymap.set(opt.mode or "n", lhs, rhs, {
            buffer = bufnr,
            noremap = true,
            silent = true,
            desc = opt.desc,
          })
        end

        set(",gr", "<cmd>GoRun<cr>", { desc = "go: run" })
      end,
    })
  end,
}
