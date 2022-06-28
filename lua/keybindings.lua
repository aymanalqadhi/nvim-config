local opts = { noremap = true, silent = true }

-- disable arrows
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', opts)

-- telescope
vim.api.nvim_set_keymap('n', ';f', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', ';r', [[
    <cmd>lua require('telescope.builtin').live_grep()<cr>
]], opts)
vim.api.nvim_set_keymap('n', ';b', [[
    <cmd>lua require('telescope.builtin').file_browser()<cr>
]], opts)
vim.api.nvim_set_keymap('n', '\\\\', '<cmd>Telescope buffers<cr>', opts)
vim.api.nvim_set_keymap('n', ';;', '<cmd>Telescope help_tags<cr>', opts)
vim.api.nvim_set_keymap('n', ' .', '<cmd>Telescope lsp_code_actions<cr>', opts)
