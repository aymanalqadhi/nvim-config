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
M.filetypes = { 'go', 'gomod' }
M.load_on_event = 'CmdlineEnter'
M.build = ':lua require("go.install").update_all_sync()'

-- plugin dependencies
M.dependencies = {
  'ray-x/guihua.lua',
  'neovim/nvim-lspconfig',
  'nvim-treesitter/nvim-treesitter',
}

-- plugin configuration function
function M.configure()
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  require('go').setup {
    lsp_cfg = {
      capabilities = capabilities,
    },
  }

  local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require('go.format').goimport()
    end,
    group = format_sync_grp,
  })
end

return M
