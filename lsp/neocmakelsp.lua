return {
  cmd = { "neocmakelsp", "--stdio" },
  filetypes = { "cmake" },
  root_markers = { "build", "cmake", ".git" },
  workspace_required = false,
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
        relative_pattern_support = true,
      },
    },
  },
  init_options = {
    format = { enable = true },
    lint = { enable = true },
    scan_cmake_in_package = true,
  },
}
