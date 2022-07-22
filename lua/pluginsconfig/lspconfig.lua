local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.

  -- formatting
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

function Configure()
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  nvim_lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  nvim_lsp.rls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  nvim_lsp.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
 
  nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  nvim_lsp.html.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  nvim_lsp.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  nvim_lsp.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities
  }

  capabilities.textDocument.completion.completionItem = {
   documentationFormat = { "markdown", "plaintext" },
   snippetSupport = true,
   preselectSupport = true,
   insertReplaceSupport = true,
   labelDetailsSupport = true,
   deprecatedSupport = true,
   commitCharactersSupport = true,
   tagSupport = { valueSet = { 1 } },
   resolveSupport = {
      properties = {
         "documentation",
         "detail",
         "additionalTextEdits",
      },
    },
  }

  nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
  }

  nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
  }

  -- icons
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
      { text = icon, texthl = "Diagnostic" .. sign, linehl = false, numhl = "Diagnostic" .. sign }
    )
  end

  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

end

return {
  configure = Configure
}
