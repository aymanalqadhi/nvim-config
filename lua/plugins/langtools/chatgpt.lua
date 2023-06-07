local M = {}

-- plugin uri
M.uri = 'jackMort/ChatGPT.nvim'

-- plugin dependencies
M.dependencies = {
  'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim'
}

-- plugin
M.lazy = true
M.load_on_cmd = 'ChatGPT'

-- plugin configuration function
function M.configure()
  require("chatgpt").setup {
    keymaps = { submit = "<C-s>" }
  }
end

-- plugin keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    g = { "<cmd>ChatGPT<cr>", "Toggle ChatGPT" },
    a = { "<cmd>ChatGPT<cr>", "Toggle ChatGPT in `Act As` mode" }
  }, { prefix = '<space>c' })
end

return M
