local M = {}

-- plugin uri
M.uri = 'VonHeikemen/lsp-zero.nvim'

-- plugin requirements
M.requirements = {
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
}

-- plugin configuration function
function M.configure()
  local lsp = require('lsp-zero')

  lsp.preset('lsp-compe')

  local function configure_clangd()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = { "utf-16" }

    lsp.configure('clangd', {
      capabilities = capabilities,
      cmd = { "clangd", '--background-index', '--clang-tidy' }
    })
  end

  -- servers config
  configure_clangd()

  lsp.nvim_workspace()
  lsp.setup()

  -- diagnostics on cursor hold
  vim.cmd [[
    autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
  ]]

end

return M
