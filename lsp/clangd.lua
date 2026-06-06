local function check_client_support(client, method)
  if not client or not client:supports_method(method) then
    vim.notify(("method %s is not supported by active servers"):format(method))
    return false
  end

  return true
end

local function switch_source_header(bufnr, client)
  local method = "textDocument/switchSourceHeader"
  if not check_client_support(client, method) then
    return
  end

  local params = vim.lsp.util.make_text_document_params(bufnr)
  client:request(method, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify("corresponding file cannot be determined")
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

local function symbol_info(bufnr, client)
  local method = "textDocument/symbolInfo"
  if not check_client_support(client, method) then
    return
  end

  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)

  client:request(method, params, function(err, res)
    if err or #res == 0 then
      return
    end

    local container = string.format("container: %s", res[1].containerName) ---@type string
    local name = string.format("name: %s", res[1].name) ---@type string

    vim.lsp.util.open_floating_preview({ name, container }, "", {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      title = "Symbol Info",
    })
  end, bufnr)
end

return {
  cmd = {
    "clangd",
    "--log=error",
    "--enable-config",
    "--background-index",
    "--clang-tidy",
    -- "--compile-commands-dir=build",
    -- "--experimental-modules-support",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--function-arg-placeholders=0",
    "--pch-storage=memory",
    "--query-driver=/usr/bin/**/clang-*,/usr/local/bin/clang*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
    "-j=12",
  },
  filetypes = { "c", "cpp" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    "aconfigure.ac",
    "CMakeLists.txt",
    "Makefile",
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    general = {
      positionEncodings = { "utf-8", "utf-16" },
    },
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
      switch_source_header(bufnr, client)
    end, { desc = "Switch between source/header" })

    vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
      symbol_info(bufnr, client)
    end, { desc = "Show symbol info" })
  end,
}
