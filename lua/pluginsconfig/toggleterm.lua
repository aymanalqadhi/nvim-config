local toggleterm = require('toggleterm')

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

local function configure()
  toggleterm.setup {
    open_mapping = [[<c-\>]],
    shade_terminals = true,
    direction = 'float',
    float_opts = {
      border = 'curved',
      winblend = 15,
    }
  }
end

return {
  configure = configure
}
