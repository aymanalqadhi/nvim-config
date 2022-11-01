local noice = require('noice')

return {
  configure = function()
    noice.setup {
      lsp = {
        signature = {
          enabled = false,
        }
      },
      presets = { inc_rename = true }
    }
  end
}
