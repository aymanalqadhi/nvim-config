local M = {}

-- plugin uri
M.uri = 'github/copilot.vim'

-- plugin options
M.lazy = true
M.load_on_cmd = 'Copilot'
M.filetypes = { 'rust', 'python', 'lua' }

return M
