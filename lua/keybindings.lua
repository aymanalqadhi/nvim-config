local opts = {
    noremap = true,
    silent = true,
}

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

-- move.nvim
vim.api.nvim_set_keymap('n', '<A-j>', ":MoveLine(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":MoveBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', ":MoveHChar(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-h>', ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-l>', ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-h>', ":MoveHBlock(-1)<CR>", { noremap = true, silent = true })

-- hover.nvim
vim.keymap.set('n',  'K', require('hover').hover       , { desc='hover.nvim'         })
vim.keymap.set('n', 'gK', require('hover').hover_select, { desc='hover.nvim (select)' })
