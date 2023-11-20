return {
  -- copilot
  {
    "zbirenbaum/copilot.lua",

    cmd = "Copilot",
    build = ":Copilot auth",
    dependencies = { "nvim-cmp" },

    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- copilot cmp source
  {
    "nvim-cmp",

    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)

              if client and client.name == "copilot" then
                copilot_cmp._on_insert_enter({})
              end
            end,
          })
        end,
      },
    },

    opts = function(_, opts)
      require("util").table.safe_extend(opts, {
        sources = require("cmp").config.sources({
          {
            name = "copilot",
            group_index = 1,
            priority = 100,
          },
        }),
      })

      return opts
    end,
  },
}
