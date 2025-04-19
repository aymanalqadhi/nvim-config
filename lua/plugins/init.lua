local M = {}

function M.load()
  M.init()

  require("lazy").setup({
    spec = {
      { import = "plugins.ui" },
      { import = "plugins.editor" },
      { import = "plugins.tooling" },
      { import = "plugins.lang" },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
          "2html_plugin",
          "getscript",
          "getscriptPlugin",
          "logipat",
          "netrw",
          "netrwSettings",
          "netrwFileHandlers",
          "tar",
          "rrhelper",
          "vimball",
          "vimballPlugin",
          "zip",
          "rplugin",
          "synmenu",
          "optwin",
          "bugreport",
        },
      },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false },
    change_detection = { enabled = false },
  })
end

function M.init()
  if not M._inited then
    M._inited = true

    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    if not vim.uv.fs_stat(lazypath) then
      local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
          { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          { out,                            "WarningMsg" },
          { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
      end
    end
    vim.opt.rtp:prepend(lazypath)
  end
end

return M
