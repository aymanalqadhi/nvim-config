local null_ls = require("null-ls")

local function configure()
  null_ls.setup{}
end

return {
  configure = configure
}
