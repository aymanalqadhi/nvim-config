local configs = require('nvim-treesitter.configs')

local function configure()
  configs.setup {
    auto_install = true,

    autotag = { enable = true },
    illuminate = { enable = true },
    incremental_selection = { enable = true },

    context_commentstring = {
      enable = true,
      commentary_integration = {
        Commentary = 'gc',
      },
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end

return {
  configure = configure
}
