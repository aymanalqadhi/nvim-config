local notify = require("notify")

local function configure()
  notify.setup {
    background_colour = "#000000",
  }
end

return {
  configure = configure
}
