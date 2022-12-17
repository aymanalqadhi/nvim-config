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
    cmd = { "clangd", '--background-index', '--clang-tidy' }
  })

  -- setup custom attach callback

  lsp.on_attach(function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end
  end)

  -- setup plugin
  lsp.nvim_workspace()
  lsp.setup()

  -- diagnostics on cursor hold
  vim.cmd [[
    autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
  ]]

end

return M
