local nvim_ts_autotag = require("nvim-ts-autotag")

local function configure()
  nvim_ts_autotag.setup {
    autotag = {
      enable = true,
    }
  }

end

return {
  configure = configure
}
