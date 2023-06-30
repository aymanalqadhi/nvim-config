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
    li = { require("lsp_lines").toggle, 'Toggle lsp lines' }
  }, { prefix = '<space>' })
end

return M
