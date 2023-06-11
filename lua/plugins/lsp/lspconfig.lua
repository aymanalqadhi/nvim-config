local M = {}

-- plugin uri
M.uri = 'neovim/nvim-lspconfig'

-- plugin dependencies
M.dependencies = {
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'hrsh7th/cmp-nvim-lsp',
}

-- plugin configuration function
function M.configure()
  -- sign icons
  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({ name = 'DiagnosticSignError', text = '' })
  sign({ name = 'DiagnosticSignWarn', text = '' })
  sign({ name = 'DiagnosticSignHint', text = '' })
  sign({ name = 'DiagnosticSignInfo', text = '' })

  -- diagnostics
  vim.diagnostic.config({
    virtual_text = { prefix = '●' },
    severity_sort = true,
    float = {
      source = 'always',
      border = 'rounded',
    },
  })

  _G.LspDiagnosticsPopupHandler = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

    if not (current_cursor[1] == last_popup_cursor[1] and
          current_cursor[2] == last_popup_cursor[2]) then
      vim.w.lsp_diagnostics_last_cursor = current_cursor
      vim.diagnostic.open_float(0, { scope = 'cursor', focus = false })
    end
  end

  vim.cmd [[
    augroup LSPDiagnosticsOnHover
      autocmd!
      autocmd CursorHold * lua _G.LspDiagnosticsPopupHandler()
    augroup END
  ]]

  -- setup lsp servers
  local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lspconfig = require('lspconfig')

  require('mason-lspconfig').setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = function(_, buf)
          vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
          vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
          vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
        end,
        capabilities = lsp_capabilities,
      })
    end,
  })

  -- custom servers setup
  lspconfig.lua_ls.setup {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim', 'require' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
  }
end

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
  }, { prefix = 'g' })

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
