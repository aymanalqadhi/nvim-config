return {
  "p00f/godbolt.nvim",

  cmd = { "Godbolt", "GodboltCompiler" },

  opts = {
    {
      languages = {
        cpp = { compiler = "clang2110", options = { userArguments = "-std=c++23 -O3" } },
        c = { compiler = "cg152", options = { userArguments = "-std=c18 -O3" } },
        rust = { compiler = "r1650", options = {} },
      },
      auto_cleanup = true,
      highlight = {
        cursor = "Visual",
        static = { "#222222", "#333333", "#444444", "#555555", "#444444", "#333333" },
      },
      quickfix = {
        enable = true,
        auto_open = true,
      },
      url = "https://godbolt.org",
    },
  },
}
