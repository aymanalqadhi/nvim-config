local M = {}

-- plugin uri
M.uri = 'RRethy/vim-illuminate'

-- plugin options
M.lazy = true
M.load_on_event = 'LspAttach'

-- plugin configuration function
function M.configure()
  require('illuminate').configure({
    delay = 200,

    filetypes_denylist = { 'NvimTree' },
    filetypes_allowlist = {},

    modes_denylist = {},
    modes_allowlist = {},

    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},

    under_cursor = true,
    min_count_to_highlight = 1,
  })
end

return M
