local null_ls = require("null-ls")

local function configure()
  null_ls.setup{
    sources = {
      null_ls.builtins.code_actions.gitsigns,
    }
  }
end

return {
  configure = configure
}
