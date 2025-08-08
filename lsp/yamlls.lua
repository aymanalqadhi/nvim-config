return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  settings = {
    yaml = {
      format = {
        enable = true,
        singleQuote = false,
      },
      completion = true,
      hover = true,
      validate = true,
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = {
        -- llvm/clang
        ["https://www.schemastore.org/clang-format.json"] = ".clang-format",
        ["https://www.schemastore.org/clangd.json"] = ".clangd",
        ["https://www.schemastore.org/clang-tidy.json"] = ".clang-tidy",
      },
    },
    redhat = {
      telemetry = { enabled = false },
    },
  },
}
