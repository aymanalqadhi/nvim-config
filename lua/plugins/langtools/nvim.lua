local M = {}

-- plugin uri
M.uri = 'folke/neodev.nvim'

-- plugin options
M.lazy = true
M.filetypes = 'lua'
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  require('neodev').setup {}

  -- setup lua
  require('lspconfig').sumneko_lua.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        }
      }
    }
  })
end

return M
