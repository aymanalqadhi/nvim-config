return {
  {
    "hrsh7th/nvim-cmp",

    branch = "main",
    event = "VeryLazy",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "windwp/nvim-autopairs",
    },

    opts = function()
      local cmp = require("cmp")

      local sources_display = {
        buffer   = "Buffer",
        cmdline  = "CMD",
        crates   = "Crates",
        copilot  = "Copilot",
        lazydev  = "LazyDev",
        luasnip  = "LuaSnip",
        nvim_lsp = "LSP",
        path     = "Path",
      }

      return {
        -- disable tab
        ["<tab>"] = cmp.config.disable,
        ["<s-tab>"] = cmp.config.disable,

        -- completion sources
        sources = {
          { name = "lazydev",  group_index = 0 },
          { name = "crates",   group_index = 1 },
          { name = "cmp-dbee", group_index = 2 },
          { name = "copilot",  group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "luasnip",  group_index = 2 },
          { name = "path",     group_index = 4 },
          { name = "buffer",   group_index = 4 },
        },

        -- key mappings
        mapping = {
          -- docs
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-b>"] = cmp.mapping.scroll_docs(-4),

          -- completion
          ["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<c-space>"] = cmp.mapping.complete(),

          -- confirmation
          ["<c-e>"] = cmp.mapping.abort(),
          ["<c-y>"] = cmp.mapping(
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
            { "i", "c" }
          ),
        },

        -- snippets
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        -- formatting
        formatting = {
          fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
          },
          format = function(entry, item)
            local source = sources_display[entry.source.name] or entry.source.name

            item.menu = "· " .. source
            item.abbr = " " .. item.abbr
            item.kind = void.config.icons.kinds[item.kind] or void.config.icons.Question

            return item
          end,
        },

        -- misc
        experimental = {
          ghost_text = { enabled = true },
        },
      }
    end,

    config = function(_, opts)
      local cmp = require("cmp")

      cmp.setup(opts)

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path", group_index = 1 },
          {
            name = "cmdline",
            group_index = 2,
            option = { ignore_cmds = { "Man", "!" } },
          },
        },
      })

      -- autopairs
      require("nvim-autopairs").setup()

      cmp.event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done()
      )
    end,
  },
}
