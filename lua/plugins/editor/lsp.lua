return {
  {
    "neovim/nvim-lspconfig",

    event = { "BufReadPost", "BufNewFile", "BufWritePre" },

    dependencies = {
      "stevearc/conform.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },

    opts = {
      -- diagnostic
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = void.config.icons.diagnostics.prefix,
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = void.config.icons.diagnostics.signs.Error,
            [vim.diagnostic.severity.WARN]  = void.config.icons.diagnostics.signs.Warning,
            [vim.diagnostic.severity.INFO]  = void.config.icons.diagnostics.signs.Info,
            [vim.diagnostic.severity.HINT]  = void.config.icons.diagnostics.signs.Hint,
          },
        },
      },

      server_defaults = {
        server_capabilities = {
          documentHighlightProvider = true,
        },
      },

      -- per-server configuration
      servers = {
        -- c/cpp
        clangd = {
          filetypes = { "c", "cpp", "objcpp", "cuda" },
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        -- golang
        gopls = {
          filetypes = {
            "go",
            "gomod",
            "gosum",
            "gotmpl",
            "gohtmltmpl",
            "gotexttmpl",
          },

          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 500,
          },

          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  commitCharactersSupport = true,
                  deprecatedSupport = true,
                  documentationFormat = { "markdown", "plaintext" },
                  preselectSupport = true,
                  insertReplaceSupport = true,
                  labelDetailsSupport = true,
                  snippetSupport = true,
                  resolveSupport = {
                    properties = {
                      "documentation",
                      "details",
                      "additionalTextEdits",
                    },
                  },
                },
                contextSupport = true,
                dynamicRegistration = true,
              },
            },
          },

          settings = {
            gopls = {
              analyses = {
                unreachable = true,
                nilness = true,
                unusedparams = true,
                useany = true,
                unusedwrite = true,
                ST1003 = true,
                undeclaredname = true,
                fillreturns = true,
                nonewvars = true,
                fieldalignment = true,
                shadow = true,
              },

              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },

              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },

              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              buildFlags = { "-tags", "integration" },
              gofumpt = true,
              semanticTokens = true,
            },
          },
        },

        -- lua
        lua_ls = {
          server_capabilities = {
            semanticTokensProvider = vim.NIL,
          },

          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              runtime = { version = "LuaJIT" },
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              -- codeLens = { enable = true },
            },
          },
        },

        -- rego
        regal = {},

        -- docker compose
        docker_compose_language_service = {},

        -- yaml
        yamlls = {
          settings = {
            format = {
              enable = true,
            },
            schemaStore = {
              enable = true,
            }
          }
        },
      },

      -- per-server setup function
      setup = {},
    },

    config = function(_, opts)
      -- diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- per-server configuration
      local lspconfig = require("lspconfig")
      local defaults = vim.deepcopy(opts.server_defaults)

      if pcall(require, "cmp_nvim_lsp") then
        defaults.capabilities = require("cmp_nvim_lsp").default_capabilities()
      else
        defaults.capabilities = vim.lsp.protocol.make_client_capabilities()
      end

      local function setup(server, config)
        lspconfig[server].setup(config and vim.tbl_deep_extend("keep", config, defaults) or defaults)
      end

      for server, config in pairs(opts.servers) do
        setup(server, config)
      end

      -- extra servers installed via mason
      require("mason-lspconfig").setup({
        handlers = {
          function(name)
            _ = not opts.servers[name] and setup(name, nil)
          end,
        },
      })

      -- on-attach config
      void.event.on("LspAttach", function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        local cfg = opts.servers[client.name]
        if cfg and cfg.server_capabilities then
          for k, v in pairs(cfg.server_capabilities) do
            client.server_capabilities[k] = v == vim.NIL and nil or v
          end
        end

        -- completion
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

        -- formatting
        vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'

        -- highlight symbol under cursor
        if client.server_capabilities.documentHighlightProvider then
          void.event.on("CursorHold", vim.lsp.buf.document_highlight, {
            group = "lsp:highlight_gain",
            buffer = bufnr
          })

          void.event.on({ "CursorMoved", "InsertEnter" }, vim.lsp.buf.clear_references, {
            group = "lsp:highlight_lose",
            buffer = bufnr,
          })
        end

        -- codelens
        if client.server_capabilities.codeLensProvider then
          void.event.on({ "BufEnter", "InsertLeave" }, function(e)
            vim.lsp.codelens.refresh({ bufnr = e.buf })
          end, { group = "lsp:codelens", buffer = bufnr })
        end

        void.keymap.buf_set(bufnr, {
          -- code navigation
          { "gld",        vim.lsp.buf.definition,       desc = "lsp: definition" },
          { "glD",        vim.lsp.buf.declaration,      desc = "lsp: declaration" },
          { "gli",        vim.lsp.buf.implementation,   desc = "lsp: implementation" },
          { "glt",        vim.lsp.buf.type_definition,  desc = "lsp: type definition" },
          { "glc",        vim.lsp.buf.outgoing_calls,   desc = "lsp: outgoing calls" },
          { "glC",        vim.lsp.buf.incoming_calls,   desc = "lsp: incoming calls" },
          { "glr",        vim.lsp.buf.references,       desc = "lsp: references" },
          { "gls",        vim.lsp.buf.document_symbol,  desc = "lsp: document symbol" },
          { "glS",        vim.lsp.buf.workspace_symbol, desc = "lsp: workspace symbol" },

          -- codelens
          { "<leader>ll", vim.lsp.codelens.run,         desc = "lsp: run codelens" },

          -- code actions
          { "<leader>la", vim.lsp.buf.code_action,      desc = "lsp: code action" },
          { "<leader>lr", vim.lsp.buf.rename,           desc = "lsp: rename" },
          {
            "<leader>lh",
            function()
              local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
              vim.lsp.inlay_hint.enable(not is_enabled)
            end,
            desc = "lsp: toggle inlay hints",
          },
          {
            "<leader>lf",
            function()
              require("conform").format({
                bufnr = bufnr,
                lsp_fallback = true,
              })
            end,

            desc = "lsp: format",
            mode = { "n", "v" },
          },

          -- diagnostics
          { "gd",    vim.diagnostic.open_float,  desc = "lsp: show diagnostic" },
          {
            "[d",
            function()
              vim.diagnostic.jump({ count = -1 })
            end,
            desc = "lsp: prev diagnostic"
          },
          {
            "]d",
            function()
              vim.diagnostic.jump({ count = 1 })
            end,
            desc = "lsp: next diagnostic"
          },

          -- assist
          { "K",     vim.lsp.buf.hover,          desc = "lsp: hover" },
          { "<c-s>", vim.lsp.buf.signature_help, desc = "lsp: signature help", mode = { "n", "i" } },
        })
      end)
    end,
  },
  {
    "stevearc/conform.nvim",

    lazy = true,

    opts = {
      formatters_by_ft = {
        lua = {},
        python = { "isort", "black" },
        cmake = { "cmake_format" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
