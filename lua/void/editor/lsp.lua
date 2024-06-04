return {
  "neovim/nvim-lspconfig",

  event = "VeryLazy",

  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },
    {
      "folke/neodev.nvim",
      ft = "lua",
      opts = {}
    },
  },

  opts = {
    -- diagnostic
    diagnostic = {
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
    -- setup diagnostics
    vim.diagnostic.config(opts.diagnostic)

    -- per-server configuration
    local lspconfig = require("lspconfig")
    local capabilities = nil

    if pcall(require, "cmp_nvim_lsp") then
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    end

    for server, server_opts in pairs(opts.servers) do
      if server_opts == true then
        server_opts = {}
      end

      if server_opts and not server_opts.manual then
        server_opts = vim.tbl_deep_extend("force", {
          capabilities = capabilities
        }, server_opts)

        lspconfig[server].setup(server_opts)
      end
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
        local bufnr = args.bufnr

        vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })

        local function set(lhs, rhs, opt)
          vim.keymap.set(opt.mode or "n", lhs, rhs, {
            buffer = bufnr,
            noremap = true,
            silent = true,
            desc = opt.desc,
          })
        end

        -- code navigation
        set("gld", vim.lsp.buf.definition, { desc = "lsp: definition" })
        set("glD", vim.lsp.buf.declaration, { desc = "lsp: declaration" })
        set("gli", vim.lsp.buf.implementation, { desc = "lsp: implementation" })
        set("glt", vim.lsp.buf.type_definition, { desc = "lsp: type definition" })
        set("glc", vim.lsp.buf.outgoing_calls, { desc = "lsp: outgoing calls" })
        set("glC", vim.lsp.buf.incoming_calls, { desc = "lsp: incoming calls" })
        set("glr", vim.lsp.buf.references, { desc = "lsp: references" })
        set("gls", vim.lsp.buf.document_symbol, { desc = "lsp: document symbol" })
        set("glS", vim.lsp.buf.workspace_symbol, { desc = "lsp: workspace symbol" })

        -- code actions
        set("<leader>la", vim.lsp.buf.code_action, { desc = "lsp: code action" })
        set("<leader>lr", vim.lsp.buf.rename, { desc = "lsp: rename" })
        set("<leader>ld", vim.diagnostic.open_float, { desc = "lsp: show diagnostic" })

        -- assits
        set("<c-s>", vim.lsp.buf.signature_help, { desc = "lsp: signature help", mode = { "n", "i" } })
        set("K", vim.lsp.buf.hover, { desc = "lsp: hover" })
        set("[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "lsp: prev diagnostic" })
        set("]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "lsp: next diagnostic" })

        -- code formatting
        set("<leader>lf", vim.lsp.buf.format, { desc = "lsp: format" })

        -- inlay hints
        set("<leader>lh", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
        end, { desc = "lsp: toggle inlay hints" })
      end
    })
  end,
}
