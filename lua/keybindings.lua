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
--vim.api.nvim_set_keymap('n', ' .', '<cmd>Telescope lsp_code_actions<cr>', opts)

-- move.nvim
vim.api.nvim_set_keymap('n', '<A-j>', ":MoveLine(1)<CR>", opts)
vim.api.nvim_set_keymap('n', '<A-k>', ":MoveLine(-1)<CR>", opts)
vim.api.nvim_set_keymap('v', '<A-j>', ":MoveBlock(1)<CR>", opts)
vim.api.nvim_set_keymap('v', '<A-k>', ":MoveBlock(-1)<CR>", opts)
vim.api.nvim_set_keymap('n', '<A-l>', ":MoveHChar(1)<CR>", opts)
vim.api.nvim_set_keymap('n', '<A-h>', ":MoveHChar(-1)<CR>", opts)
vim.api.nvim_set_keymap('v', '<A-l>', ":MoveHBlock(1)<CR>", opts)
vim.api.nvim_set_keymap('v', '<A-h>', ":MoveHBlock(-1)<CR>", opts)

-- hover.nvim
vim.keymap.set('n',  'K', require('hover').hover       , { desc='hover.nvim'         })
vim.keymap.set('n', 'gK', require('hover').hover_select, { desc='hover.nvim (select)' })

-- lspconfig
vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
vim.api.nvim_set_keymap("n", '<space>f', '<cmd>lua vim.lsp.buf.format{ async =true }<CR>', opts)
vim.api.nvim_set_keymap('x', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting({})<CR>', opts)

-- trouble
vim.api.nvim_set_keymap("n", "<space>t", "<cmd>TroubleToggle<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)
