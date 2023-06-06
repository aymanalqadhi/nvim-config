local M = {}

-- plugin uri
M.uri = 'glepnir/dashboard-nvim'

-- plugin dependencies
M.dependencies = { 'nvim-tree/nvim-web-devicons' }

-- plugin options
M.lazy = true
M.load_on_event = 'VimEnter'

-- plugin configuration function
function M.configure()
  require('dashboard').setup {
    theme = 'hyper',
    config = {
      week_header = {
       enable = true,
      },
      shortcut = {
        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Git Status',
          group = 'DiagnosticHint',
          action = 'Telescope git_status',
          key = 's',
        },
        {
          desc = ' Git Commits',
          group = 'Number',
          action = 'Telescope git_commits',
          key = 'c',
        },
      },
    },
  }

end

return M
