local M = {}

-- plugin uri
M.uri = 'luukvbaal/statuscol.nvim'

-- plugin configuration function
function M.configure()
  local builtin = require('statuscol.builtin')

  require('statuscol').setup {
    relculright = true,
    segments = {
      { text = { '%s' }, click = 'v:lua.ScSa' },
      {
        text = { builtin.lnumfunc, ' ' },
        condition = { true, builtin.not_empty },
        click = 'v:lua.ScLa',
      },
      { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
    },
  }
end

return M
