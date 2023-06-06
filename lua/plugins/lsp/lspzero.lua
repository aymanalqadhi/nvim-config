local M = {}

-- plugin uri
M.uri = 'VonHeikemen/lsp-zero.nvim'

-- plugin dependencies
M.dependencies = {
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
}

-- plugin configuration function
function M.configure()
  local lsp = require('lsp-zero')

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.offsetEncoding = { "utf-16" }

  lsp.preset('lsp-compe')

  -- icons
  lsp.set_preferences {
    sign_icons = {
      error = '',
      warn = '',
      hint = '',
      info = '',
    }
  }

  -- servers config
  lsp.configure('clangd', {
    capabilities = capabilities,
    filetypes = { 'c', 'cpp' },
    cmd = { 'clangd', '--background-index', '--clang-tidy' }
  })

  -- setup plugin
  lsp.nvim_workspace()
  lsp.setup()

  -- diagnostics on cursor hold
  vim.cmd [[
    autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
  ]]
end

return M
