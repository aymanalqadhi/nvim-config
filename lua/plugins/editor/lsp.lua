return {
  {
    "neovim/nvim-lspconfig",

    event = { "BufReadPost", "BufNewFile", "BufWritePre" },

    dependencies = {
      "stevearc/conform.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
      },
    },

    opts = function()
      local icons = Void.config.icons

      return {
        -- diagnostic
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = icons.diagnostics.prefix,
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = icons.diagnostics.signs.Error,
              [vim.diagnostic.severity.WARN] = icons.diagnostics.signs.Warning,
              [vim.diagnostic.severity.INFO] = icons.diagnostics.signs.Info,
              [vim.diagnostic.severity.HINT] = icons.diagnostics.signs.Hint,
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
            cmd = { "gopls", "-remote.debug=:0" },
            message_level = vim.lsp.protocol.MessageType.Error,
            filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
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
                diagnostics = {
                  globals = { "vim" },
                },
                runtime = { version = "LuaJIT" },
                workspace = { checkThirdParty = false },
                completion = { callSnippet = "Replace" },
                codeLens = { enable = true },
                doc = { privateName = { "^_" } },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
                telemetry = { enable = false },
              },
            },
          },

          pyright = {},
        },
      }
    end,

    config = function(_, opts)
      -- diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- ui
      require("lspconfig.ui.windows").default_options.border = "none"

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
            if not opts.servers[name] then
              setup(name, nil)
            end
          end,
        },
      })

      -- on-attach config
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          -- completion
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

          -- highlight symbol under cursor
          if client.server_capabilities.documentHighlightProvider then
            local augroup = vim.api.nvim_create_augroup("void.lsp.document_highlight", {
              clear = false,
            })

            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })
            vim.api.nvim_create_autocmd("CursorHold", {
              group = augroup,
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
              group = augroup,
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- codelens
          if client.supports_method("textDocument/codeLens") then
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
              group = vim.api.nvim_create_augroup("void-codelens", { clear = true }),
              buffer = bufnr,
              callback = vim.lsp.codelens.refresh,
            })
          end

          -- keymaps
          Void.keymap.set({
            -- code navigation
            gl = {
              d = { vim.lsp.buf.definition, "lsp: definition" },
              D = { vim.lsp.buf.declaration, "lsp: declaration" },
              i = { vim.lsp.buf.implementation, "lsp: implementation" },
              t = { vim.lsp.buf.type_definition, "lsp: type definition" },
              c = { vim.lsp.buf.outgoing_calls, "lsp: outgoing calls" },
              C = { vim.lsp.buf.incoming_calls, "lsp: incoming calls" },
              r = { vim.lsp.buf.references, "lsp: references" },
              s = { vim.lsp.buf.document_symbol, "lsp: document symbol" },
              S = { vim.lsp.buf.workspace_symbol, "lsp: workspace symbol" },
            },

            -- code actions
            ["<leader>l"] = {
              a = { vim.lsp.buf.code_action, "lsp: code action" },
              r = { vim.lsp.buf.rename, "lsp: rename" },
              h = {
                function()
                  local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = opts.bufnr })
                  vim.lsp.inlay_hint.enable(not is_enabled)
                end,
                "lsp: toggle inlay hints",
              },
              f = {
                function()
                  require("conform").format({
                    bufnr = bufnr,
                    async = true,
                    lsp_fallback = true,
                  })
                end,
                "lsp: format",

                mode = { "n", "v" },
              },
            },

            -- diagnostics
            {
              ["gd"] = { vim.diagnostic.open_float, "lsp: show diagnostic" },
              ["[d"] = {
                function()
                  vim.diagnostic.jump({ count = -1 })
                end,
                "lsp: prev diagnostic",
              },
              ["]d"] = {
                function()
                  vim.diagnostic.jump({ count = 1 })
                end,
                "lsp: next diagnostic",
              },
            },

            -- assist
            {
              K = { vim.lsp.buf.hover, "lsp: hover" },

              ["<c-s>"] = { vim.lsp.buf.signature_help, "lsp: signature help", mode = { "n", "i" } },
            },

            opts = { buffer = args.bufnr },
          })

          local settings = opts.servers[client.name]

          if settings and settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })
    end,

    init = function()
      vim.cmd([[
        hi! def  LspReferenceRead  cterm=bold gui=underline
        hi! def  LspReferenceWrite cterm=bold gui=underline
        hi! link LspReferenceText  CursorLine
      ]])
    end,
  },
  {
    "stevearc/conform.nvim",

    event = "LspAttach",

    opts = {
      formatters_by_ft = {
        lua = {},
        python = { "isort", "black" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },

    config = function(_, opts)
      require("conform").setup(opts)
    end,

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
