return {
  "neovim/nvim-lspconfig",

  event = { "BufReadPost", "BufNewFile", "BufWritePre" },

  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
  },

  opts = {
    -- diagnostic
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.INFO]  = " ",
          [vim.diagnostic.severity.HINT]  = " ",
        },
      },
      float = {
        format = function(d)
          if not d.code and d.user_data and d.user_data.lsp then
            return string.format("%s [%s]", d.message, d.user_data.lsp.code):gsub("1. ", "")
          end

          return d.message
        end,
      },
    },

    -- per-server configuration
    servers = {
      clangd = {
        filetypes = { "c", "cpp" },
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

      gopls = {
        filetypes = { 'go', 'gomod', 'gosum', 'gotmpl', 'gohtmltmpl', 'gotexttmpl' },
        message_level = vim.lsp.protocol.MessageType.Error,
        cmd = { 'gopls', '-remote.debug=:0' },
        flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                commitCharactersSupport = true,
                deprecatedSupport = true,
                documentationFormat = { 'markdown', 'plaintext' },
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                snippetSupport = true,
                resolveSupport = {
                  properties = {
                    'documentation',
                    'details',
                    'additionalTextEdits',
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

            -- codelenses = {
            --   generate = true,
            --   gc_details = true,
            --   run_govulncheck = true,
            --   test = true,
            --   tidy = true,
            --   vendor = true,
            --   regenerate_cgo = true,
            --   upgrade_dependency = true,
            -- },

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
            matcher = 'Fuzzy',
            diagnosticsDelay = '500ms',
            symbolMatcher = 'fuzzy',
            semanticTokens = true,
            -- noSemanticTokens = true,
            buildFlags = { '-tags', 'integration' },
            gofumpt = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
          },
        },
      },

      lua_ls = {
        capabilities = {},
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            completion = { callSnippet = "Replace" },
            codeLens = { enable = true },
            telemetry = { enable = false },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      },

      pyright = {},
    },
  },

  config = function(_, opts)
    -- diagnostics
    vim.diagnostic.config(opts.diagnostics)

    -- ui
    require("lspconfig.ui.windows").default_options.border = "none"

    -- per-server configuration
    local lspconfig = require("lspconfig")
    local capabilities = nil

    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    local function setup(server, config)
      config = vim.tbl_deep_extend("keep", config or {}, {
        capabilities = capabilities,
      })

      lspconfig[server].setup(config)
    end

    for server, config in pairs(opts.servers) do
      setup(server, config)
    end

    -- extra servers installed via mason
    require("mason-lspconfig").setup({
      handlers = {
        function(name)
          if not opts.servers[name] then
            lspconfig[name].setup({ capabilities = capabilities })
          end
        end
      }
    })

    -- on-attach config
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = opts.bufnr })

        -- diagnostics on cursor hold
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = args.bufnr,
          callback = function()
            vim.diagnostic.open_float(nil, {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = "none",
              source = "always",
            })
          end,
        })

        -- keymaps
        require("void.core.keymap").set({
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
            f = { vim.lsp.buf.format, "lsp: format" },
            h = {
              function()
                local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = opts.bufnr })
                vim.lsp.inlay_hint.enable(not is_enabled)
              end,
              "lsp: toggle inlay hints",
            },
          },

          -- diagnostics
          {
            ["gd"] = { vim.diagnostic.open_float, "lsp: show diagnostic" },
            ["[d"] = { function() vim.diagnostic.jump({ count = -1 }) end, "lsp: prev diagnostic" },
            ["]d"] = { function() vim.diagnostic.jump({ count = 1 }) end, "lsp: next diagnostic" },
          },

          -- assist
          {
            K = { vim.lsp.buf.hover, "lsp: hover" },

            ["<c-s>"] = { vim.lsp.buf.signature_help, "lsp: signature help", mode = { "n", "i" } },
          },

          opts = { buffer = args.bufnr },
        })
      end
    })
  end,
}
