-- installtion path of `lazy.nvim`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- clone `lazy.nvim` if not already cloned
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

-- add `lazy.nvim` to runtime paths
vim.opt.rtp:prepend(lazypath)

-- initialize plugins
require('lazy').setup(require('plugins.init'), {})
