local M = {}

function M.on(event, callback, opts)
  local log = require("util.log")

  if not callback then
    log.error("callback is required")
    return
  end

  opts = vim.tbl_extend("force", opts or {}, {
    pattern = event,
    callback = callback,
  })

  vim.api.nvim_create_autocmd("User", opts)
end

function M.emit(event, args, opts)
  opts = vim.tbl_extend("force", opts or {}, {
    pattern = event,
    data = args,
  })

  vim.api.nvim_exec_autocmds("User", opts)
end

return M
