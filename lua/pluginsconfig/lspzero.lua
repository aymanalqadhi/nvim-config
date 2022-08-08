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

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  local signs = { Error = "", Warn = "", Info = "כֿ", Hint = "" }

  for sign, icon in pairs(signs) do
    vim.fn.sign_define(
      "DiagnosticSign" .. sign,
      {
        text = icon,
        texthl = "Diagnostic" .. sign,
        linehl = true,
        numhl = "Diagnostic" .. sign
      }
    )
  end

  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

  lsp.preset('lsp-compe')
  
  lsp.on_attach(function(client, bufnr)
    require 'illuminate'.on_attach(client)
  end)

  lsp.setup()
end

return {
  configure = configure
}
