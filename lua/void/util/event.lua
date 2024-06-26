local M = {}

function M.group(name, clear)
  return vim.api.nvim_create_augroup("void.autocmd." .. name, {
    clear = clear,
  })
end

function M.on(event, callback, opts)
  if opts then
    if type(callback) ~= "string" then
      assert(not opts.callback)
      opts.callback = callback
    else
      assert(not opts.command)
      opts.command = callback
    end

    if type(opts.group) == "string" then
      opts.group = M.group(opts.group)
    end
  else
    opts = { callback = callback }
  end

  return vim.api.nvim_create_autocmd(event, opts)
end

return M
