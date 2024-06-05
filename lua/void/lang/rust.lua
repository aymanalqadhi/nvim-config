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
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        pattern = "rust",
        group = vim.api.nvim_create_augroup("void-rust", { clear = true }),
        callback = function(args)
          require("void.core.keymap").register({
            {
              a = { "<cmd>RustLsp codeAction<cr>", "rust: code actions" },
              d = { "<cmd>RustLsp debuggables<cr>", "rust: debuggables" },
              D = { "<cmd>RustLsp debug<cr>", "rust: debug" },
              e = { "<cmd>RustLsp explainError<cr>", "rust: explain error" },
              h = {
                a = { "<cmd>RustLsp hover actions<cr>", "rust: hover actions" },
                r = { "<cmd>RustLsp hover range<cr>", "rust: hover range" },
              },
              m = { "<cmd>RustLsp expandMacro<cr>", "rust: expand macro" },
              r = { "<cmd>RustLsp runnables<cr>", "rust: runnables" },
              R = { "<cmd>RustLsp run<cr>", "rust: run" },
              t = { "<cmd>RustLsp testables<cr>", "rust: testables" },
              T = { "<cmd>RustTest<cr>", "rust: test" },
              v = {
                a = { "<cmd>RustEmitAsm<cr>", "rust: view asm" },
                i = { "<cmd>RustEmitIr<cr>", "rust: view llvm ir" },
                h = { "<cmd>RustLsp view hir<cr>", "rust: view hir" },
                m = { "<cmd>RustLsp view mir<cr>", "rust: view mir" },
              },
              prefix = ",r",
            },

            opts = { buffer = args.bufnr },
          })
        end,
      })
    end,
  },

  -- Extend auto completion
  {
    "Saecki/crates.nvim",

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
          require("void.core.keymap").register({
            K = { crates.show_popup, "rust: show crate documentation" },

            opts = { buffer = args.bufnr },
          })
        end
      })
    end
  },
}
