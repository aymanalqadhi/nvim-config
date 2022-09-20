local tmux = require("tmux")

local function configure()
  tmux.setup {
    copy_sync = {
      enable = true,
      redirect_to_clipboard = true,
    },
  }
end

return {
  configure = configure
}
