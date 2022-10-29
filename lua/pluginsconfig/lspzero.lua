local lsp = require('lsp-zero')

local function configure()
  -- virtual text errors
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 4,
      prefix = '◉',
    }
  }
  )

  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
  lsp.preset('lsp-compe')
  lsp.nvim_workspace()

  lsp.on_attach(function(client, _)
    require 'illuminate'.on_attach(client)
  end)

  -- clangd encoding offest fix
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.offsetEncoding = { "utf-16" }

  lsp.configure('clangd', {
    capabilities = capabilities,
    cmd = { "clangd", '--background-index', '--clang-tidy' }
  })

  lsp.setup()
end

return {
  configure = configure
}
