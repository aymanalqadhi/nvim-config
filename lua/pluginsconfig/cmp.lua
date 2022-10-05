local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")
local lspkind = require("lspkind")

local function t(v)
  return vim.api.nvim_replace_termcodes(v, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
end

local function tab(fallback)
  local luasnip = require "luasnip"
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(t "<C-n>", "n")
  elseif luasnip.expand_or_jumpable() then
    vim.fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
  elseif check_back_space() then
    vim.fn.feedkeys(t "<tab>", "n")
  else
    fallback()
  end
end

local function shift_tab(fallback)
  local luasnip = require "luasnip"
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(t "<C-p>", "n")
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(t "<Plug>luasnip-jump-prev", "")
  else
    fallback()
  end
end

local function configure()
  cmp.setup({
    completion = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, scrollbar = "║" },
    window = {
      documentation = {
        border = "rounded",
        scrollbar = "║",
      },
      completion = {
        border = "rounded",
        scrollbar = "║",
      },
    },
    formatting = {
      fields = {
        cmp.ItemField.Kind,
        cmp.ItemField.Abbr,
        cmp.ItemField.Menu,
      },
      format = lspkind.cmp_format({
        with_text = false,
        before = function(entry, vim_item)
          -- Get the full snippet (and only keep first line)
          local word = entry:get_insert_text()
          if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
            word = vim.lsp.util.parse_snippet(word)
          end
          word = str.oneline(word)

          -- concatenates the string
          local max = 50
          if string.len(word) >= max then
            local before = string.sub(word, 1, math.floor((max - 3) / 2))
            word = before .. "..."
          end

          if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
              and string.sub(vim_item.abbr, -1, -1) == "~"
          then
            word = word .. "~"
          end
          vim_item.abbr = word

          return vim_item
        end,
      }),
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(tab, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s" }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      },
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    },
    experimental = {
      ghost_text = true,
    },
  })

  require('cmp').setup.cmdline(":", {
    sources = {
      { name = "cmdline", keyword_length = 2 },
    },
  })
end

return {
  configure = configure
}
