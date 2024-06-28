local M = { _init = false }

_G.Void = {
  config = require("void.config"),

  -- utils
  keymap = require("void.util.keymap"),
  event  = require("void.util.event")
}

function M.setup()
  assert(not M._init, "already bootstrapped")

  M._init = true

  -- initilize lazy.nvim
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  -- load plugins
  require("lazy").setup("plugins", {
    change_detection = { enabled = false },
    defaults = {
      version = false,
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
  })
end

return M
