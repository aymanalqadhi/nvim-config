local M = {}

-- plugin uri
M.uri = 'utilyre/barbecue.nvim'

-- plugin dependencies
M.dependencies = {
  'neovim/nvim-lspconfig',
  'smiteshp/nvim-navic',
  'kyazdani42/nvim-web-devicons',
}

-- plugin configuration function
function M.configure()
  require('barbecue').setup {
    create_autocmd = false,
  }

  vim.api.nvim_create_autocmd({
    "WinScrolled",
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    "BufWritePost",
    "TextChanged",
    "TextChangedI",
  }, {
    group = vim.api.nvim_create_augroup("barbecue", {}),
    callback = function()
      require("barbecue.ui").update()
    end,
  })
end

return M
