return {
  {
    "L3MON4D3/LuaSnip",

    version = "*",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        build = "make install_jsregexp",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_lua").load({ paths = "./lua/plugins/editor/luasnip/snips/*.lua" })
        end,
      },
    },

    opts = function()
      local types = require("luasnip.util.types")

      return {
        history = true,
        delete_check_events = "TextChanged",
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        ext_opts = {
          [types.insertNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              virt_text_pos = "inline",
            },
          },
          [types.exitNode] = {
            unvisited = {
              virt_text = { { "|", "Conceal" } },
              virt_text_pos = "inline",
            },
          },
        },
        snip_env = {
          ts_show = function(pred)
            return function()
              local row, col = unpack(vim.api.nvim_win_get_cursor(0))
              local ok, node = pcall(vim.treesitter.get_node, { pos = { row - 1, col - 1 } })

              -- Show the snippet if Treesitter bails.
              if not ok or not node then
                return true
              end

              return pred(node:type())
            end
          end,
        },
      }
    end,

    config = function(_, opts)
      local ls = require("luasnip")

      -- set config
      ls.config.set_config(opts)

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
            ls.unlink_current()
          end
        end,
      })
    end,
  },

  -- set snippet expansion key bindings
  {
    "nvim-cmp",

    dependencies = {
      "saadparwaiz1/cmp_luasnip",
    },

    opts = function(_, opts)
      local ls = require("luasnip")
      local cmp = require("cmp")

      require("util").table.safe_extend(opts, {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        sources = require("cmp").config.sources({
          { name = "luasnip" },
        }),

        mapping = {
          ["<C-j>"] = cmp.mapping(function(fallback)
            if ls.expand_or_jumpable() then
              ls.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-k>"] = cmp.mapping(function(fallback)
            if ls.jumpable(-1) then
              ls.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-l>"] = cmp.mapping(function(fallback)
            if ls.choice_active() then
              ls.change_choice(1)
            else
              fallback()
            end
          end, { "i" }),

          ["<C-u>"] = cmp.mapping(function(_)
            require("luasnip.extras.select_choice")
          end, { "i" }),
        },
      })

      return opts
    end,
  },
}
