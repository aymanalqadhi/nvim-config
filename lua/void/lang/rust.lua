return {
  {
    "mrcjkb/rustaceanvim",

    ft = { "rust" },

    keys = {
      { "K",   "<cmd>RustHoverActions<cr>", desc = "rust: hover actions" },
      { ",ra", "<cmd>RustCodeAction<cr>",   desc = "rust: code actions" },
      { ",rd", "<cmd>RustDebuggables<cr>",  desc = "rust: debuggables" },
      { ",re", "<cmd>RustExpand<cr>",       desc = "rust: expand" },
      { ",rt", "<cmd>RustTest<cr>",         desc = "rust: test" },
      { ",rr", "<cmd>RustRun<cr>",          desc = "rust: test" },
    },

    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                enable = true,
                enableExperimental = true,
                experimental = {
                  enable = true,
                },
              },
              completion = {
                autoself = { enable = true },
                autoimport = { enable = true },
                postfix = { enable = true },
              },
            },
          },
        },

        tools = {
          code_actions = {
            ui_select_fallback = true,
          },
        },
      }
    end,
  },

  -- Extend auto completion
  {
    "Saecki/crates.nvim",

    event = { "BufRead Cargo.toml" },
    keys = {
      {
        "K",
        function()
          if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
            require("crates").show_popup()
          else
            vim.lsp.buf.hover()
          end
        end,
        desc = "Show Crate Documentation",
      },
    },

    opts = {
      source = {
        cmp = { enabled = true },
      },
    },
  },
}
