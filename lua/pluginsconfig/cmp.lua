local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")
local lspkind = require("lspkind")

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

          if
            entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
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
       -- REQUIRED - you must specify a snippet engine
       expand = function(args)
         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
         -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
       end,
     },
     mapping = {
       ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
       ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
       ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
       ['<C-y>'] = cmp.config.disable,
       ['<C-e>'] = cmp.mapping({
         i = cmp.mapping.abort(),
         c = cmp.mapping.close(),
       }),
       ['<CR>'] = cmp.mapping.confirm({ select = true }),
     },

    -- You should specify your *installed* sources.
     sources = cmp.config.sources{
       { name = 'nvim_lsp' },
       { name = 'vsnip' }, -- For vsnip users.
       -- { name = 'luasnip' }, -- For luasnip users.
       -- { name = 'ultisnips' }, -- For ultisnips users.
       -- { name = 'snippy' }, -- For snippy users.
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
