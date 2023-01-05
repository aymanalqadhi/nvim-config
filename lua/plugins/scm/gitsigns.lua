local M = {}

-- plugin uri
M.uri = 'lewis6991/gitsigns.nvim'

-- plugin options
M.lazy = true
M.load_on_keys = '<space>g'

-- plugin configuration function
function M.configure()
  require('gitsigns').setup()
end

-- plugin keymaps
function M.set_keymaps(k)
  local gs = require('gitsigns')

  -- normal mode keys (<space> prefix)
  k.register({
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
  }, { prefix = '<space>'})

  -- normal mode keys (navigation)
  k.register({
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
  })

  -- text object modes keys
  k.register({
    ['ih'] = { mode = { 'o', 'x' }, ':<C-U>Gitsigns select_hunk<CR>', 'Select Hunk' },
  }, { mode = { 'o', 'x' } })

end

return M
