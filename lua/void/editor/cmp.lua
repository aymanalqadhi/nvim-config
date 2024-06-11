return {
  {
    "hrsh7th/nvim-cmp",
    branch = "main",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "windwp/nvim-autopairs",
    },

    event = { "InsertEnter", "CmdlineEnter" },

    opts = function(_, opts)
      local kinds = {
        Array         = "",
        Boolean       = "󰨙",
        Class         = "󰠱",
        Codeium       = "󰘦",
        Color         = "",
        Control       = "",
        Collapsed     = "",
        Constant      = "󰏿",
        Constructor   = "",
        Copilot       = "",
        Enum          = "",
        EnumMember    = "",
        Event         = "",
        Field         = "",
        File          = "",
        Folder        = "",
        Function      = "󰊕",
        Interface     = "",
        Key           = "",
        Keyword       = "󰌋",
        Method        = "󰊕",
        Module        = "",
        Namespace     = "󰦮",
        Null          = "󰟢",
        Number        = "󰎠",
        Object        = "",
        Operator      = "",
        Package       = "",
        Property      = "",
        Reference     = "",
        Snippet       = "",
        String        = "",
        Struct        = "󰆼",
        TabNine       = "󰏚",
        Text          = "",
        TypeParameter = "󰆩",
        Unit          = "",
        Value         = "",
        Variable      = "󰀫",
        Unknown       = "",
      }

      local cmp = require("cmp")

      return vim.tbl_deep_extend("keep", {
        -- disable tab
        ["<tab>"] = cmp.config.disable,
        ["<s-tab>"] = cmp.config.disable,

        -- completion sources
        sources = {
          { name = "nvim_lsp", group_index = 2 },
          { name = "path",     group_index = 4 },
          { name = "buffer",   group_index = 4 },
        },

        -- sorting
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        -- key mappings
        mapping = {
          -- docs
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),

          -- completion
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<c-space>"] = cmp.mapping.complete(),

          -- confirmation
          ["<c-e>"] = cmp.mapping.abort(),
          ["<c-y>"] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
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
          format = function(_, item)
            item.menu = " · " .. (item.kind or "Unknown")
            item.kind = kinds[item.kind] or kinds.Unknown
            item.abbr = " " .. item.abbr

            return item
          end,
        },

        -- misc
        experimental = {
          ghost_text = {
            enabled = true,
          },
          native_menu = false,
        },
      }, opts)
    end,

    config = function(_, opts)
      local cmp = require("cmp")

      cmp.setup(opts)

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
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