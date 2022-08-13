local toggleterm = require('toggleterm')

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

local function configure()
  toggleterm.setup {
    open_mapping = [[<c-\>]],
    shade_terminals = true,
    direction = 'float'
  }
end

return {
  configure = configure
}
