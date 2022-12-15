local M = {}

-- plugin uri
M.uri = 'lewis6991/gitsigns.nvim'

-- plugin configuration function
function M.configure()
  require('gitsigns').setup()
end

-- plugin keymaps
function M.keymaps()
  local gs = require('gitsigns')

  return {
    ['<space>g'] = {
      name = 'git',
      a = { gs.stage_buffer, 'Stage Buffer' },
      u = { gs.undo_stage_hunk, 'Unstage Hunk' },
      r = { gs.reset_buffer, 'Reset Buffer' },
      p = { gs.preview_hunk, 'Preview Hunk' },
      b = { function() gs.blame_line { full = true } end, 'Blame Line' },
      B = { gs.toggle_current_line_blame, 'Toggle Current Line Blame' },
      d = { gs.diffthis, 'Diff This' },
      D = { function() gs.diffthis('~') end, 'Diff All' },
      t = { gs.toggle_deleted, 'Toggle Deleted' },
      l = { '<cmd>Gitsigns toggle_linehl<cr>', 'Toggle Line Highlight' },
      w = { '<cmd>Gitsigns toggle_word_diff<cr>', 'Toggle Word Diff' },
    },
    -- Text object
    ['ih'] = { mode = { 'o', 'x' }, ':<C-U>Gitsigns select_hunk<CR>', 'Select Hunk' },

    -- -- Navigation
    [']c'] = {
      function()
        if vim.wo.diff then
          return ']c'
        end

        vim.schedule(function() gs.next_hunk() end)

        return '<Ignore>'
      end,
      'Next Hunk',
    },

    ['[c'] = {
      function()
        if vim.wo.diff then
          return '[c'
        end

        vim.schedule(function() gs.prev_hunk() end)

        return '<Ignore>'
      end,
      'Previous Hunk',
    },
  }
end

return M
