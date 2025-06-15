-- base config
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
  root_markers = { ".git" },
})

-- enable servers
vim.lsp.enable({
  "bashls",
  "clangd",
  "gopls",
  "jsonls",
  "lua_ls",
  "neocmakelsp",
  "taplo",
  "yamlls",
})

-- setup on client attach
void.event.on("LspAttach", function(args)
  local bufnr = args.buf
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

  -- highlight symbol under cursor
  if client.server_capabilities.documentHighlightProvider then
    void.event.on("CursorHold", vim.lsp.buf.document_highlight, {
      group = "lsp:highlight_gain",
      buffer = bufnr,
    })

    void.event.on({ "CursorMoved", "InsertEnter" }, vim.lsp.buf.clear_references, {
      group = "lsp:highlight_lose",
      buffer = bufnr,
    })
  end

  -- codelens
  if client.server_capabilities.codeLensProvider then
    void.event.on({ "BufEnter", "InsertLeave" }, function(e)
      vim.lsp.codelens.refresh({ bufnr = e.buf })
    end, { group = "lsp:codelens", buffer = bufnr })
  end

  void.keymap.buf_set(bufnr, {
    -- code navigation
    { "gld", vim.lsp.buf.definition, desc = "lsp: definition" },
    { "glD", vim.lsp.buf.declaration, desc = "lsp: declaration" },
    { "gli", vim.lsp.buf.implementation, desc = "lsp: implementation" },
    { "glt", vim.lsp.buf.type_definition, desc = "lsp: type definition" },
    { "glc", vim.lsp.buf.outgoing_calls, desc = "lsp: outgoing calls" },
    { "glC", vim.lsp.buf.incoming_calls, desc = "lsp: incoming calls" },
    { "glr", vim.lsp.buf.references, desc = "lsp: references" },
    { "gls", vim.lsp.buf.document_symbol, desc = "lsp: document symbol" },
    { "glS", vim.lsp.buf.workspace_symbol, desc = "lsp: workspace symbol" },

    -- codelens
    { "<leader>ll", vim.lsp.codelens.run, desc = "lsp: run codelens" },

    -- code actions
    { "<leader>la", vim.lsp.buf.code_action, desc = "lsp: code action" },
    { "<leader>lr", vim.lsp.buf.rename, desc = "lsp: rename" },
    {
      "<leader>lh",
      function()
        local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not is_enabled)
      end,
      desc = "lsp: toggle inlay hints",
    },
    { "<leader>lf", vim.lsp.buf.format, desc = "lsp: format", mode = { "n", "v" } },

    -- assist
    { "K", vim.lsp.buf.hover, desc = "lsp: hover" },
    { "<c-s>", vim.lsp.buf.signature_help, desc = "lsp: signature help", mode = { "n", "i" } },
  })
end, { group = "lsp" })

-- commands
vim.api.nvim_create_user_command("LspInfo", function(_)
  vim.cmd.checkhealth("vim.lsp")
end, { desc = "lsp: check health" })

vim.api.nvim_create_user_command("LspLog", function(_)
  vim.cmd.tabnew(vim.lsp.get_log_path())
end, { desc = "lsp: open logs file" })
