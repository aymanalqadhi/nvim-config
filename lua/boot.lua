local M = {
  bootstrapped = false,
}

local log = require("util.log")

-- Require nvim-0.10 or newer
if vim.fn.has("nvim-0.10") ~= 1 then
  log.fatal("nvim >= 0.10 is required")
end

--- Loads configuraiton & plugins
function M.bootstrap(opts)
  -- run this function only once
  if M.bootstrapped then
    return
  end

  -- load config
  require("config").setup(opts or {})

  -- load plugins
  M.load_plugins()

  Mabootstrapped = true
end

--- Loads/reloads plugins
function M.load_plugins()
  -- make sure `lazy.nvim` is installed
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- load plugins spec
  local spec = {}
  local root = require("plugins")

  local function load_plugin(cat, name)
    local path = string.format("plugins.%s.%s", cat, name)
    local loaded, plugin = pcall(require, path)

    if not loaded then
      log.error("could not load plugin %s", path)
    else
      table.insert(spec, plugin)
    end
  end

  for cat, value in pairs(root) do
    if type(value) == "string" then
      load_plugin(cat, value)
    elseif type(value) == "table" then
      if vim.tbl_isarray(value) then
        for _, plugin in ipairs(value) do
          load_plugin(cat, plugin)
        end
      else
        table.insert(spec, value)
      end
    else
      log.fatal("invalid plugin spec: %s", type(value))
    end
  end

  -- apply plugins specs
  require("lazy").setup(spec, {
    ui = {
      icons = {
        ft = "",
        lazy = "󰂠 ",
        loaded = "",
        not_loaded = "",
      },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "2html_plugin",
          "tohtml",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
          "tutor",
          "rplugin",
          "syntax",
          "synmenu",
          "optwin",
          "compiler",
          "bugreport",
          "ftplugin",
        },
      },
    },
  })
end

return M
