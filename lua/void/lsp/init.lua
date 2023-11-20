---Lsp module.
---@class void.lsp
local M = require("void.util.module").make("void.lsp")

---A wrapper around `vim.api.nvim_create_augroup` for lsp attach events.
---@param on_attach any The on_attach function to call.
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      on_attach(client, buffer)
    end,
  })
end

return M
