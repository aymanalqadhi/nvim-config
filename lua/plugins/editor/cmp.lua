return {
  "hrsh7th/nvim-cmp",

  version = false,
  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },

  opts = function(_, opts)
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp = require("cmp")

    require("util").table.safe_extend(opts, {
      mapping = cmp.mapping.preset.insert({
        -- docs
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- confirmation
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          { "i", "c" }
        ),
        ["<M-y>"] = cmp.mapping(
          cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          { "i", "c" }
        ),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,

        -- completion
        ["<c-space>"] = cmp.mapping({
          i = cmp.mapping.complete(),
          c = function(
            _ --[[fallback]]
          )
            if cmp.visible() then
              if not cmp.confirm({ select = true }) then
                return
              end
            else
              cmp.complete()
            end
          end,
        }),
        ["<C-n>"] = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end,
        ["<C-p>"] = function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end,

        -- disable tab
        ["<tab>"] = cmp.config.disable,
      }),

      -- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua
      sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,

          -- copied from cmp-under, but I don't think I need the plugin for this.
          -- I might add some more of my own.
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find("^_+")
            local _, entry2_under = entry2.completion_item.label:find("^_+")
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,

          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 4 },
      }),

      formatting = {
        fields = {
          cmp.ItemField.Kind,
          cmp.ItemField.Abbr,
          cmp.ItemField.Menu,
        },
        format = function(_, vim_item)
          local MAX_ABBR_WIDTH, MAX_MENU_WIDTH = 25, 30
          local ELLIPSIS = "…"

          local icons = require("config.icons")

          -- Truncate the label.
          if vim.api.nvim_strwidth(vim_item.abbr) > MAX_ABBR_WIDTH then
            vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, MAX_ABBR_WIDTH) .. ELLIPSIS
          end

          -- Truncate the description part.
          if vim.api.nvim_strwidth(vim_item.menu or "") > MAX_MENU_WIDTH then
            vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, MAX_MENU_WIDTH) .. ELLIPSIS
          end

          vim_item.menu = "   · " .. (vim_item.kind or "Unknown")
          vim_item.kind = icons.kinds[vim_item.kind] or icons.misc.question

          if vim_item.abbr then
            vim_item.abbr = " " .. vim_item.abbr
          else
            vim_item.word = " " .. vim_item.word
          end

          return vim_item
        end,
      },

      window = {
        completion = {
          border = { "", "", "", "", "", "", "", "" }, -- ║
        },
      },

      experimental = {
        native_menu = false,
        ghost_text = {
          -- enabled = true,
          hl_group = "CmpGhostText",
        },
      },
    })

    return opts
  end,

  config = function(_, opts)
    local cmp = require("cmp")

    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end

    cmp.setup(opts)

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}
