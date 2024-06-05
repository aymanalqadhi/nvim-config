return {
  {
    "mrcjkb/rustaceanvim",

    ft = { "rust" },

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
      vim.api.nvim_create_augroup("void-rust", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        pattern = "rust",
        callback = function(args)
          local bufnr = args.bufnr

          local function set(lhs, rhs, opt)
            vim.keymap.set(opt.mode or "n", lhs, rhs, {
              buffer = bufnr,
              noremap = true,
              silent = true,
              desc = opt.desc,
            })
          end

          set("K", "<cmd>RustHoverActions<cr>", { desc = "rust: hover actions" })
          set(",ra", "<cmd>RustCodeAction<cr>", { desc = "rust: code actions" })
          set(",rd", "<cmd>RustDebuggables<cr>", { desc = "rust: debuggables" })
          set(",re", "<cmd>RustExpand<cr>", { desc = "rust: expand" })
          set(",rt", "<cmd>RustTest<cr>", { desc = "rust: test" })
          set(",rr", "<cmd>RustRun<cr>", { desc = "rust: test" })
        end,
      })
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
