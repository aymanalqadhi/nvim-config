local M = {}

-- plugin uri
M.uri = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

-- plugin options
M.lazy = true
M.load_on_keys = '<space>li'

-- plugin configuration function
function M.configure()
  require('lsp_lines').setup {}
end

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    li = {
      function()
        local new_value = not vim.diagnostic.config().virtual_lines

        vim.diagnostic.config({
          virtual_lines = new_value,
          virtual_text = not new_value,
        })
      end,
      'Toggle lsp lines'
    }
  }, { prefix = '<space>' })
end

return M
