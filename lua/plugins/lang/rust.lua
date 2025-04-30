return {
  {
    "mrcjkb/rustaceanvim",

    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy

    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              experimental = {
                serverStatusNotification = true,
              },
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },

    opts = {
      completion = {
        blink = {
          use_custom_kind = true,
          kind_text = {
            version = "Version",
            feature = "Feature",
          },
          kind_highlight = {
            version = "BlinkCmpKindVersion",
            feature = "BlinkCmpKindFeature",
          },
          kind_icon = {
            version = " ",
            feature = " ",
          },
        },
        crates = {
          enabled = true,
          min_chars = 3,
          max_results = 8,
        },
      },
      lsp = {
        enabled = true,
        name = "crates.nvim",
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
