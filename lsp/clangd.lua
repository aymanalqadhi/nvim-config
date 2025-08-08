return {
  cmd = {
    "clangd",
    "--log=error",
    "--enable-config",
    "--background-index",
    "--clang-tidy",
    "--compile-commands-dir=build",
    "--completion-style=detailed",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
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
}
