return {
  {
    "folke/lazydev.nvim",

    ft = "lua",

    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      integrations = {
        -- lspconfig = true,
        cmp = false,
        coq = false,
      },
    },
  },
  {
    "saghen/blink.cmp",

    optional = true,

    opts = {
      sources = {
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            -- score_offset = 100,
            fallbacks = { "lsp" },
          },
        },
      },
    },
  },
}
