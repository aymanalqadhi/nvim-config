local configs = require('nvim-treesitter.configs')

local function configure()
  configs.setup {
    context_commentstring = {
      enable = true,
      commentary_integration = {
        Commentary = 'gc',
      },
    }
  }
end

return {
  configure = configure
}
