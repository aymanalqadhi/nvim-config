local function run_with_env(cb)
  if vim.g.go_env then
    cb(vim.g.go_env)
    return
  end

  local cmd = { "go", "env", "GOROOT", "GOMODCACHE" }
  local opt = { text = true, stderr = false }

  vim.system(cmd, opt, function(out)
    if out.code == 0 then
      local vars = vim.split(out.stdout, "\n", {
        plain = true,
        trimempty = false,
      })
      assert(#vars >= 2, "output must contain two lines")
      vim.g.go_env = {
        root = vars[1],
        mod_cache = vars[2],
      }
    end

    vim.schedule(function()
      cb(vim.g.go_env)
    end)
  end)
end

return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gosum", "gotmpl" },

  root_dir = function(bufnr, set)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    run_with_env(function(env)
      if vim.startswith(fname, env.root) or vim.startswith(fname, env.mod_cache) then
        local clients = vim.lsp.get_clients({ name = "gopls" })
        if #clients > 0 then
          set(clients[#clients].config.root_dir)
          return
        end
      end

      set(vim.fs.root(fname, { "go.mod", "go.work", ".git" }))
    end)
  end,

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
      gofumpt = true,
      semanticTokens = true,
    },
  },
}
