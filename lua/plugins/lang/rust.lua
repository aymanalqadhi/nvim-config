return {
  {
    "mrcjkb/rustaceanvim",
    version = false,

    ft = { "rust" },
    keys = {
      { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
      { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
      { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
    },

    init = function()
      vim.g.rustaceanvim = {
        server = {
          standalone = false,

          ["rust-analyzer"] = {
            settings = {
              ["rust-analyzer"] = {
                diagnostics = {
                  enable = true,
                  -- https://github.com/rust-analyzer/rust-analyzer/issues/6835
                  disabled = { "unresolved-macro-call" },
                  enableExperimental = true,
                },
                completion = {
                  autoself = { enable = true },
                  autoimport = { enable = true },
                  postfix = { enable = true },
                },
                imports = {
                  group = { enable = true },
                  merge = { glob = false },
                  prefix = "self",
                  granularity = {
                    enforce = true,
                    group = "crate",
                  },
                },
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  runBuildScripts = true,
                },
                -- Add clippy lints for Rust.
                checkOnSave = {
                  allFeatures = true,
                  command = "clippy",
                  extraArgs = { "--no-deps" },
                },
                procMacro = {
                  enable = true,
                  ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                  },
                },
              },
            },
            tools = {
              inlay_hints = {
                auto = true,
              },
            },
          },
        },
      }
    end,
  },

  -- Extend auto completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          src = {
            cmp = { enabled = true },
          },
        },
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
      },
    },
    opts = function(_, opts)
      require("util").table.safe_extend(opts, {
        sources = {
          { name = "crates" },
        },
      })

      return opts
    end,
  },

  -- Ensure Rust debugger is installed
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },
}
-- local make_options = function(server)
--   local ok, mason_reg = pcall(require, "mason-registry")
--   local adapter
--
--   if ok then
--     local codelldb = mason_reg.get_package("codelldb")
--     local ext_path = codelldb:get_install_path() .. "/extension/"
--     local codelldb_path = ext_path .. "adapter/codelldb"
--     local liblldb_path = ""
--
--     if vim.loop.os_uname().sysname:find("Windows") then
--       liblldb_path = ext_path .. "lldb\\bin\\liblldb.dll"
--     elseif vim.fn.has("mac") == 1 then
--       liblldb_path = ext_path .. "lldb/lib/liblldb.dylib"
--     else
--       liblldb_path = ext_path .. "lldb/lib/liblldb.so"
--     end
--     adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
--   end
--
--   return {
--     server = server,
--     dap = {
--       adapter = adapter,
--     },
--     tools = {
--       on_initialized = function()
--         vim.cmd([[
--           augroup RustLSP
--             autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
--             autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
--             autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
--           augroup END
--         ]])
--       end,
--     },
--   }
-- end
--
-- return {
--   -- Extend auto completion
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       {
--         "Saecki/crates.nvim",
--         event = { "BufRead Cargo.toml" },
--         opts = {
--           src = {
--             cmp = { enabled = true },
--           },
--         },
--       },
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       local cmp = require("cmp")
--       opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
--         { name = "crates" },
--       }))
--     end,
--   },
--
--   -- Ensure Rust debugger is installed
--   {
--     "williamboman/mason.nvim",
--     optional = true,
--     opts = function(_, opts)
--       if type(opts.ensure_installed) == "table" then
--         vim.list_extend(opts.ensure_installed, { "codelldb" })
--       end
--     end,
--   },
--
--   {
--     "Ciel-MC/rust-tools.nvim",
--     lazy = true,
--   },
--
--   -- Correctly setup lspconfig for Rust 🚀
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       servers = {
--         -- Ensure mason installs the server
--         rust_analyzer = {
--           keys = {
--             { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
--             { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
--             { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
--           },
--           settings = {
--             ["rust-analyzer"] = {
--               cargo = {
--                 allFeatures = true,
--                 loadOutDirsFromCheck = true,
--                 runBuildScripts = true,
--               },
--               -- Add clippy lints for Rust.
--               checkOnSave = {
--                 allFeatures = true,
--                 command = "clippy",
--                 extraArgs = { "--no-deps" },
--               },
--               procMacro = {
--                 enable = true,
--                 ignored = {
--                   ["async-trait"] = { "async_trait" },
--                   ["napi-derive"] = { "napi" },
--                   ["async-recursion"] = { "async_recursion" },
--                 },
--               },
--             },
--           },
--           tools = {
--             inlay_hints = {
--               auto = false,
--             },
--           },
--         },
--         taplo = {
--           keys = {
--             {
--               "K",
--               function()
--                 if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
--                   require("crates").show_popup()
--                 else
--                   vim.lsp.buf.hover()
--                 end
--               end,
--               desc = "Show Crate Documentation",
--             },
--           },
--         },
--       },
--       setup = {
--         rust_analyzer = function(_, opts)
--           require("rust-tools").setup(make_options(opts))
--           return true
--         end,
--       },
--     },
--   },
--
--   {
--     "nvim-neotest/neotest",
--     optional = true,
--     dependencies = {
--       "rouge8/neotest-rust",
--     },
--     opts = {
--       adapters = {
--         ["neotest-rust"] = {},
--       },
--     },
--   },
-- }
