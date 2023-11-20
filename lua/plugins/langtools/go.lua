local M = {}

-- plugin uri
M.uri = 'ray-x/go.nvim'
M.dependencies = {
  'ray-x/guihua.lua',
  'neovim/nvim-lspconfig',
  'nvim-treesitter/nvim-treesitter',
}

-- plugin options
-- M.lazy = true
M.lazy = true
M.filetypes = { 'go', 'gomod' }
M.load_on_event = 'CmdlineEnter'
M.build = ':lua require("go.install").update_all_sync()'

-- plugin dependencies
M.dependencies = {
  'ray-x/guihua.lua',
  'neovim/nvim-lspconfig',
  'nvim-treesitter/nvim-treesitter',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
}

-- plugin configuration function
function M.configure()
  require("mason").setup()
  require("mason-lspconfig").setup()

  require('go').setup {
    max_line_len = 88,
    lsp_cfg = false,
    lsp_keymaps = false,
    lsp_inlay_hints = {
      enable = false,
      parameter_hints_prefix = "󰊕 ",
      show_parameter_hints = true,
      other_hints_prefix = "=> ",
      highlight = "Comment",
    },
    dap_debug_keymap = false,
    trouble = true,
    luasnip = true,
  }

  -- lsp config
  local cfg = require 'go.lsp'.config()
  require('lspconfig').gopls.setup(cfg)

  -- format on save
  local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require('go.format').gofmt()
    end,
    group = format_sync_grp,
  })

  -- keymaps
  vim.cmd [[ autocmd FileType go nmap <space>lgl GoLint ]]
  vim.cmd [[ autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()]]
end

return M
