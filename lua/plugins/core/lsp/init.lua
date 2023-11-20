local methods = vim.lsp.protocol.Methods

return {
  -- lspconfig: core lsp configuration plugin
  "neovim/nvim-lspconfig",

  dependencies = {
    {
      "folke/neodev.nvim",
      opts = {},
    },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-telescope/telescope.nvim",
  },

  --- @class PluginLspOpts
  opts = function(_, opts)
    local cfg = require("config")

    local new_opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 2,
          source = "if_many",
          prefix = cfg.lsp.virtual_text_prefix,
        },
        severity_sort = true,
        signs = true,
        float = {
          show_header = true,
          format = function(d)
            if not d.code and not d.user_data then
              return d.message
            end

            local t = vim.deepcopy(d)
            local code = d.code
            if not code then
              if not d.user_data.lsp then
                return d.message
              end

              code = d.user_data.lsp.code
            end
            if code then
              t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
            end
            return t.message
          end,
        },
      },

      -- native inlay hints
      inlay_hints = {
        enabled = cfg.lsp.inlay_hints,
        auto = false,
      },

      -- global capabilities
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              documentationFormat = { "markdown", "plaintext" },
              snippetSupport = true,
              preselectSupport = true,
              insertReplaceSupport = true,
              labelDetailsSupport = true,
              deprecatedSupport = true,
              commitCharactersSupport = true,
              tagSupport = { valueSet = { 1 } },
              resolveSupport = {
                properties = {
                  "documentation",
                  "detail",
                  "additionalTextEdits",
                },
              },
            },
          },
        },
        workspace = {
          didChangeWatchedFiles = { dynamicRegistration = false },
        },
      },

      -- formatting options
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      servers = {
        lua_ls = {
          -- keys = {},
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              maxPreload = 0x10000,
              preloadFileSize = 0x2000,
            },
          },
        },

        clangd = {
          filetypes = { "c", "cpp" },
          cmd = {
            "clangd",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=none",
          },
          capabilities = {
            -- Prevents the 'multiple different client offset_encodings detected for buffer' warning.
            offsetEncoding = { "utf-16" },
          },
        },
      },

      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    }

    return vim.tbl_deep_extend("error", opts, new_opts)
  end,

  config = function(_, opts)
    local keymaps = require("plugins.core.lsp.keymaps")

    -- client attach event
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- set keymaps
        keymaps.set(buffer)

        if not client then
          return
        end

        -- inlay hints
        if client.supports_method(methods.textDocument_inlayHint) then
          vim.lsp.inlay_hint(buffer, false)
          vim.lsp.inlay_hint(buffer, true)
        end

        -- show diagnostics on hover
        if client.supports_method(methods.textDocument_signatureHelp) then
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
        end
      end,
    })

    -- set keymaps on register capability
    local register_capability = vim.lsp.handlers["client/registerCapability"]
    vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
      local ret = register_capability(err, res, ctx)
      keymaps.set(vim.api.nvim_get_current_buf())
      return ret
    end

    -- signs
    for name, icon in pairs(require("config").icons.diagnostics) do
      name = "DiagnosticSign" .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
    end

    -- diagnostics
    if opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = function(diagnostic)
        for d, icon in pairs(require("config").icons.diagnostics) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end
    end
    vim.diagnostic.config(opts.diagnostics)

    -- setup server capabilities
    local servers = opts.servers
    local capabilities =
      vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), opts.capabilities or {})

    -- extend capabilities with cmp_nvim_lsp
    local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
    end

    -- mason integration
    local function setup(server)
      local server_capabilities = servers[server]
          and servers[server].capabilities
          and vim.tbl_deep_extend("force", capabilities, servers[server].capabilities)
        or capabilities

      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = server_capabilities,
      }, servers[server] or {})

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end

      require("lspconfig")[server].setup(server_opts)
    end

    local have_mason, mason_lsp = pcall(require, "mason-lspconfig")
    if have_mason then
      local mason_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      local ensure_installed = {}

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false or not vim.tbl_contains(mason_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      mason_lsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
    end
  end,

  init = function()
    -- register formatter
    require("util").format.register({
      name = "LSP",
      enabled = true,
      priority = 150,
      format = vim.lsp.buf.format,
      formatexpr = function()
        return vim.lsp.formatexpr({})
      end,
    })
  end,
}
