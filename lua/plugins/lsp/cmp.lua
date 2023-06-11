local M = {}

-- plugin uri
M.uri = 'hrsh7th/nvim-cmp'

-- plugin dependencies
M.dependencies = {
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-cmdline',
  'zbirenbaum/copilot-cmp',
  'L3MON4D3/LuaSnip',
  'windwp/nvim-autopairs',
}

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  local cmp = require('cmp')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local luasnip = require('luasnip')

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local cmp_kinds = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '󰈙',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '󰏿',
    Struct = '',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '',
    Copilot = '',
  }

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered({
        winhighlight = 'FloatBorder:LspInfoBorder',
      }),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = {
        cmp.ItemField.Kind,
        cmp.ItemField.Abbr,
        cmp.ItemField.Menu,
      },
      format = function(_, vim_item)
        vim_item.menu = '     · ' .. (vim_item.kind or '')
        vim_item.kind = (cmp_kinds[vim_item.kind] or vim_item.kind) .. ' '

        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert {
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      },
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    },
    sources = cmp.config.sources {
      { name = 'copilot',  group_index = 2 },
      { name = 'nvim_lsp', group_index = 2 },
      { name = 'path',     group_index = 2 },
      { name = 'luasnip',  group_index = 2 },
    },
    experimental = {
      ghost_text = true,
    }
  })

  cmp.setup.cmdline(':', {
    sources = {
      { name = 'cmdline' },
      { name = 'path' }
    }
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
  })

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

return M
