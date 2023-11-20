local M = {}

-- plugin uri
M.uri = 'zbirenbaum/copilot.lua'

-- plugin dependencies
M.dependencies = 'zbirenbaum/copilot-cmp'

-- plugin configuration function
function M.configure()
  require('copilot').setup {
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = '[[',
        jump_next = ']]',
        accept = '<CR>',
        refresh = 'gr',
        open = '<M-CR>'
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = '<M-l>',
        accept_word = false,
        accept_line = false,
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
    filetypes = {
      -- enabled
      c = true,
      cpp = true,
      python = true,
      rust = true,
      toml = true,
      go = true,
      sql = true,
    },
    server_opts_overrides = {},
  }

  require("copilot_cmp").setup()
end

return M
