local telescope = require("telescope")

local function configure()
  telescope.setup {
    defaults = {
      file_ignore_patterns = {
        ".git",
        "build",
        "target",
      },
    }
  }
end

return {
    configure = configure
}
