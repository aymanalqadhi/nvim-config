local M = {}

function M.set(buffer)
  local km = require("util.keymap")

  local function kset(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_deep_extend("force", {
      buffer = buffer,
      desc = desc,
    }, opts or {})

    km.set(mode, lhs, rhs, opts)
  end

  vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"

  -- navigation
  kset("n", "gll", "<cmd>LspInfo<cr>", "LSP Info")
  kset("n", "gld", vim.lsp.buf.definition, "Goto Definition")
  kset("n", "glD", vim.lsp.buf.declaration, "Goto Declaration")
  kset("n", "gli", vim.lsp.buf.implementation, "Goto Implementation")
  kset("n", "glt", vim.lsp.buf.type_definition, "Goto Type Definition")
  kset("n", "glc", vim.lsp.buf.outgoing_calls, "Goto Outgoing Calls")
  kset("n", "glC", vim.lsp.buf.incoming_calls, "Goto Incoming Calls")
  kset("n", "glr", vim.lsp.buf.references, "Goto References")
  kset("n", "gls", vim.lsp.buf.document_symbol, "Goto Document Symbols")
  kset("n", "glS", vim.lsp.buf.workspace_symbol, "Goto Workspace Symbols")

  -- editing
  kset("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
  kset("n", "<leader>lf", function()
    require("util.format").format({
      buffer = buffer,
      async = false,
    })
  end, "Format")
  kset("n", "<leader>la", vim.lsp.buf.code_action, "Code Action")
  kset("n", "<leader>lh", function()
    vim.lsp.inlay_hint(0, nil)
  end, "Toggle Inlay Hints")

  -- diagnostics
  kset("n", "<leader>le", vim.diagnostic.open_float, "Show Line Diagnostics")
  kset("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
  kset("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

  -- documentation
  kset("n", "K", vim.lsp.buf.hover, "Hover")
  kset("i", "<A-k>", vim.lsp.buf.signature_help, "Signature Help")
end

return M
