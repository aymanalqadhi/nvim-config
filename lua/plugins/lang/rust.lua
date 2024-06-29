return {
  {
    "mrcjkb/rustaceanvim",

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

    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern  = "rust",
        group    = vim.api.nvim_create_augroup("void-rust", { clear = true }),
        callback = function(args)
          void.keymap.buf_set(args.buf, {
            { "<localleader>ra",  "<cmd>RustLsp codeAction<cr>",    desc = "rust: code actions" },
            { "<localleader>rd",  "<cmd>RustLsp debuggables<cr>",   desc = "rust: debuggables" },
            { "<localleader>rD",  "<cmd>RustLsp debug<cr>",         desc = "rust: debug" },
            { "<localleader>re",  "<cmd>RustLsp explainError<cr>",  desc = "rust: explain error" },
            { "<localleader>rha", "<cmd>RustLsp hover actions<cr>", desc = "rust: hover actions" },
            { "<localleader>rhr", "<cmd>RustLsp hover range<cr>",   desc = "rust: hover range",  mode = { "v" } },
            { "<localleader>rm",  "<cmd>RustLsp expandMacro<cr>",   desc = "rust: expand macro" },
            { "<localleader>rr",  "<cmd>RustLsp runnables<cr>",     desc = "rust: runnables" },
            { "<localleader>rR",  "<cmd>RustLsp run<cr>",           desc = "rust: run" },
            { "<localleader>rt",  "<cmd>RustLsp testables<cr>",     desc = "rust: testables" },
            { "<localleader>rT",  "<cmd>RustTest<cr>",              desc = "rust: test" },
            { "<localleader>rva", "<cmd>RustEmitAsm<cr>",           desc = "rust: view asm" },
            { "<localleader>rvi", "<cmd>RustEmitIr<cr>",            desc = "rust: view llvm ir" },
            { "<localleader>rvh", "<cmd>RustLsp view hir<cr>",      desc = "rust: view hir" },
            { "<localleader>rvm", "<cmd>RustLsp view mir<cr>",      desc = "rust: view mir" },
          })
        end,
      })
    end,
  },

  -- Extend auto completion
  {
    "Saecki/crates.nvim",

    dependencies = { "hrsh7th/nvim-cmp" },
    event = { "BufRead Cargo.toml" },

    opts = {
      completion = {
        cmp = { enabled = true },
        crates = { enabled = true },
      },
    },

    config = function(_, opts)
      local crates = require("crates")

      crates.setup(opts)

      vim.api.nvim_create_autocmd("BufRead", {
        pattern = { "Cargo.toml" },
        group = vim.api.nvim_create_augroup("void-crates", { clear = true }),
        callback = function(args)
          void.keymap.buf_set(args.buf, {
            { "K", crates.show_popup, desc = "rust: show crate documentation" },
          })
        end
      })
    end
  },
}
