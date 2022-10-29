local noice = require('noice')

return {
  configure = function()
    noice.setup {
      lsp = {
        signature = {
          enabled = false,
        }
      }
    }
  end
}
