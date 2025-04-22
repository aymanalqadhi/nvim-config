---@class Void.event
local M = {}

function M.group(name, clear)
  return vim.api.nvim_create_augroup("void.autocmd." .. name, {
    clear = clear,
  })
end

function M.on(event, callback, opts)
  if opts then
    if type(callback) ~= "string" then
      assert(not opts.callback, "callback can only be specified once")
      opts.callback = callback
    else
      assert(not opts.command, "callback can only be specified once")
      opts.command = callback
    end

    if type(opts.group) == "string" then
      opts.group = M.group(opts.group, false)
    end
  else
    opts = { callback = callback }
  end

  return vim.api.nvim_create_autocmd(event, opts)
end

return M
