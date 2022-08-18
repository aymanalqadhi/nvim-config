local null_ls = require("null-ls")

local function configure()
  null_ls.setup{
    sources = {
      null_ls.builtins.code_actions.gitsigns,
    },
    on_init = function(new_client, _) 
      new_client.offset_encoding = 'utf-8'
    end,
  }
end

return {
  configure = configure
}
