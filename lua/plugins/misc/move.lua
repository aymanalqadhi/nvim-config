local M = {}

-- plugin uri
M.uri = 'fedepujol/move.nvim'

-- plugin keymaps
function M.keymaps()
  return {
    ['<A-j>'] = {
      { '<cmd>MoveLine(1)<cr>', 'Move Line Down' },
      { mode = 'v', '<cmd>MoveBlock(1)<cr>', 'Move Block Down' },
    },
    ['<A-k>'] = {
      { '<cmd>MoveLine(-1)<cr>', 'Move Line Up' },
      { mode = 'v', '<cmd>MoveBlock(-1)<cr>', 'Move Block Up' },
    },
    ['<A-h>'] = {
      { '<cmd>MoveHChar(-1)<cr>', 'Left-Shift Character' },
      { mode = 'v', '<cmd>MoveHBlock(-1)<cr>', 'Left-Shift Block' },
    },
    ['<A-l>'] = {
      { '<cmd>MoveHChar(1)<cr>', 'Right-Shift Character' },
      { mode = 'v', '<cmd>MoveHBlock(1)<cr>', 'Right-Shift Block' },
    },
  }
end

return M
