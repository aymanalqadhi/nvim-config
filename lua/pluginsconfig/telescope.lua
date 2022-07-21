local telescope = require("telescope")

local function configure()
  telescope.setup {
    defaults = {
      file_ignore_patterns = {
        ".git",
        "build",
        "target",
        "node_modules",
      },
    }
  }
end

return {
    configure = configure
}
