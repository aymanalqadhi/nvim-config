return {
  "L3MON4D3/LuaSnip",

  build = "make install_jsregexp",
  dependencies = { "rafamadriz/friendly-snippets" },

  event = "InsertEnter",

  config = function()
    local ls = require("luasnip")

    -- configuration
    ls.config.set_config {
      keep_roots = true,
      link_roots = true,
      link_children = true,
      exit_roots = false,
    }

    -- load snippets
    require("luasnip.loaders.from_lua").lazy_load()

    -- override expand function
    vim.snippet.expand = ls.lsp_expand
    vim.snippet.stop = ls.unlink_current
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.active = function(filter)
      if not filter or filter.direction ~= 1 then
        return ls.jumpable(filter.direction)
      else
        return ls.expand_or_jumpable()
      end
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.snippet.jump = function(direction)
      if direction == 1 and ls.expandable() then
        return ls.expand_or_jump()
      else
        return ls.jumpable(direction) and ls.jump(direction)
      end
    end

    -- key mappings
    local function activate(direction)
      return function()
        return vim.snippet.active { direction = direction } and vim.snippet.jump(direction)
      end
    end

    vim.keymap.set({ "i", "s" }, "<c-j>", activate(1), { silent = true })
    vim.keymap.set({ "i", "s" }, "<c-k>", activate(-1), { silent = true })
  end,
}
