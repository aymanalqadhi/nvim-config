local twilight = require('twilight')

return {
  configure = function()
    twilight.setup {
      dimming = {
        alpha = 0.5,
      }
    }
  end
}
