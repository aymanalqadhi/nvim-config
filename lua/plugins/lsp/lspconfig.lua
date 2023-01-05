local M = {}

-- plugin uri
M.uri = 'neovim/nvim-lspconfig'

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys (`<space>` prefix)
  k.register({
    l = {
      name = 'lsp',
      a = { vim.lsp.buf.code_action, 'Code Actions' },
      f = { vim.lsp.buf.format, 'Format Code' },
      r = { vim.lsp.buf.rename, 'Rename' },
      s = { '<cmd>Telescope spell_suggest theme=dropdown<cr>', 'Spell' },
      l = { vim.lsp.codelens.display, 'Display CodeLens' },
      L = { vim.lsp.codelens.refresh, 'Refresh CodeLens' },
      w = {
        name = 'workspace',
        l = { vim.lsp.buf.list_workspace_folders, 'List' },
        a = { vim.lsp.buf.add_workspace_folder, 'Add' },
        d = { vim.lsp.buf.remove_workspace_folder, 'Remove' },
      }
    }
  }, { prefix = '<space>' })

  -- normal mode keys (`g` prefix)
  k.register({
    l = {
      name = 'lsp-jump',
      d = { vim.lsp.buf.definition, 'Definition' },
      D = { vim.lsp.buf.declaration, 'Declaration' },
      t = { vim.lsp.buf.type_definition, 'Type' },
      i = { vim.lsp.buf.implementation, 'Implementation' },
      r = { vim.lsp.buf.references, 'References' },
      c = { vim.lsp.buf.outgoing_calls, 'Outgoing Calls' },
      C = { vim.lsp.buf.incoming_calls, 'Incoming Calls' },
      s = { vim.lsp.buf.document_symbol, 'Document Symbol' },
      S = { vim.lsp.buf.workspace_symbol, 'Workspace Symbol' },
    }
  }, { prefix = '<space>' })

  -- normal mode keys (misc)
  k.register({
    [']d'] = { vim.diagnostic.goto_next, 'Next Diagnostic' },
    ['[d'] = { vim.diagnostic.goto_prev, 'Previous Diagnostic' },
  })

  -- insert mode keys
  k.register({
    ['<C-k>'] = { mode = 'i', vim.lsp.buf.signature_help, 'Signature Help' },
  }, { mode = 'i' })

end

return M
