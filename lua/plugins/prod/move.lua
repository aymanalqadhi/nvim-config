local M = {}

-- plugin uri
M.uri = 'fedepujol/move.nvim'

-- plugin keymaps
function M.keymaps()
  return {
    ['<A-j>'] = {
      { mode = 'v', '<cmd>MoveBlock(1)<cr>', 'Move Block Down' },
      { '<cmd>MoveLine(1)<cr>', 'Move Line Down' },
    },
    ['<A-k>'] = {
      { mode = 'v', '<cmd>MoveBlock(-1)<cr>', 'Move Block Up' },
      { '<cmd>MoveLine(-1)<cr>', 'Move Line Up' },
    },
    ['<A-h>'] = {
      { mode = 'v', '<cmd>MoveHBlock(-1)<cr>', 'Left-Shift Block' },
      { '<cmd>MoveHChar(-1)<cr>', 'Left-Shift Character' },
    },
    ['<A-l>'] = {
      { mode = 'v', '<cmd>MoveHBlock(1)<cr>', 'Right-Shift Block' },
      { '<cmd>MoveHChar(1)<cr>', 'Right-Shift Character' },
    },
  }
end

return M
