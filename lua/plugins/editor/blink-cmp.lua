return {
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
      nerd_font_variant = "mono"
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
            { "kind_icon", "label", "label_description", "source_name", gap = 1 },
          },
          components = {
            label = {
              text = function(ctx) return " " .. ctx.label end,
            },
            source_name = { highlight = "Comment", }
          },
          treesitter = { "lsp" }
        }
      },
      ghost_text = { enabled = true },
    },

    sources = {
      default = function(_)
        local ok, node = pcall(vim.treesitter.get)
        if ok and node and vim.tbl_contains({
              "comment",
              "line_comment",
              "block_comment"
            }, node:type()) then
          return { "path", "buffer" }
        end

        if vim.bo.filetype == "lua" then
          return { "lazydev", "lsp", "path", "snippets", "buffer" }
        end

        -- fallback
        return { "lsp", "path", "snippets", "buffer" }
      end,
      providers = {},
    },

    signature = { enabled = true },
  },

  opts_extend = {
    "sources.default",
  },
}
