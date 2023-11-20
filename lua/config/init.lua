-- add defaults

local M = require("util.module").supermod("config", {
  lsp = {
    inlay_hints = true,
    virtual_text_prefix = "icons", -- ●,
  },
  colorscheme = "onedark",
})

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", M, opts or {})

  -- update current options
  M.current = opts
end

return M
