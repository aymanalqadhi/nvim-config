local M = {}

-- plugin uri
M.uri = 'nvim-treesitter/nvim-treesitter'

-- plugin configuration function
function M.configure()

  require('nvim-treesitter.configs').setup {
    -- auto install missing parsers
    auto_install = true,

    -- highlighting module
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }

end

return M
