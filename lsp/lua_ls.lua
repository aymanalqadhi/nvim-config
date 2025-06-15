return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      codeLens = { enable = true },
      diagnostics = { globals = { "vim", "void" } },
      doc = { privateName = { "^_" } },
      completion = { callSnippet = "Replace" },
      hint = { enable = true },
      runtime = { version = "LuaJIT" },
      semantic = { enable = false },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
}
