return {
  {
    "saghen/blink.cmp",

    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },

    event = "InsertEnter",

    opts = {
      keymap = {
        preset = "none",

        -- completion
        ["<c-e>"] = { "hide" },
        ["<c-y>"] = { "select_and_accept" },
        ["<c-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<c-n>"] = { "select_next", "fallback_to_mappings" },
        ["<c-space>"] = { "show", "show_documentation", "hide_documentation" },

        -- snippets
        ["<c-k>"] = { "snippet_backward", "fallback" },
        ["<c-j>"] = { "snippet_forward", "fallback" },

        -- docs
        ["<c-f>"] = { "scroll_documentation_down", "fallback" },
        ["<c-b>"] = { "scroll_documentation_up", "fallback" },
        ["<c-l>"] = { "show_signature", "hide_signature", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
          draw = {
            padding = 1,
            columns = {
              { "kind_icon", "sep", "label", gap = 1 },
            },
            components = {
              sep = {
                text = function(_)
                  return ""
                end,
              },
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
              source_name = {
                highlight = "Comment",
              },
            },
          },
        },
        ghost_text = { enabled = true },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
        },
      },

      signature = { enabled = true },
    },

    opts_extend = {
      "sources.default",
    },
  },
  {
    "xzbdmw/colorful-menu.nvim",
    lazy = true,
    opts = {},
  },
}
