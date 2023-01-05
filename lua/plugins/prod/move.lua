local M = {}

-- plugin uri
M.uri = 'fedepujol/move.nvim'

-- plugin configuration
function M.configure()
end

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    ['<A-j>'] = { '<cmd>MoveLine(1)<cr>', 'Move Line Down' },
    ['<A-k>'] = { '<cmd>MoveLine(-1)<cr>', 'Move Line Up' },
    ['<A-h>'] = { '<cmd>MoveHChar(-1)<cr>', 'Move Character Left' },
    ['<A-l>'] = { '<cmd>MoveHChar(1)<cr>', 'Move Character Right' },
  })

  -- visual mode keys
  k.register({
    ['<A-j>'] = { '<cmd>MoveBlock(1)<cr>', 'Move Block Down' },
    ['<A-k>'] = { '<cmd>MoveBlock(-1)<cr>', 'Move Block Up' },
    ['<A-h>'] = { '<cmd>MoveHBlock(-1)<cr>', 'Move Block Left' },
    ['<A-l>'] = { '<cmd>MoveHBlock(1)<cr>', 'Move Block Right' },
  }, { mode = 'v' })

end

return M
