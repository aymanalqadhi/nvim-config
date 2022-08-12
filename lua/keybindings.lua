local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- disable arrows
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)

-- telescope
map('n', ';f', '<cmd>Telescope find_files<cr>', opts)
map('n', ';r', [[
    <cmd>lua require('telescope.builtin').live_grep()<cr>
]], opts)
map('n', ';b', [[
    <cmd>lua require('telescope.builtin').file_browser()<cr>
]], opts)
map('n', '\\\\', '<cmd>Telescope buffers<cr>', opts)
map('n', ';;', '<cmd>Telescope help_tags<cr>', opts)
--map('n', ' .', '<cmd>Telescope lsp_code_actions<cr>', opts)

-- move.nvim
map('n', '<A-j>', ":MoveLine(1)<CR>", opts)
map('n', '<A-k>', ":MoveLine(-1)<CR>", opts)
map('v', '<A-j>', ":MoveBlock(1)<CR>", opts)
map('v', '<A-k>', ":MoveBlock(-1)<CR>", opts)
map('n', '<A-l>', ":MoveHChar(1)<CR>", opts)
map('n', '<A-h>', ":MoveHChar(-1)<CR>", opts)
map('v', '<A-l>', ":MoveHBlock(1)<CR>", opts)
map('v', '<A-h>', ":MoveHBlock(-1)<CR>", opts)

-- hover.nvim
vim.keymap.set('n',  'K', require('hover').hover       , { desc='hover.nvim'         })
vim.keymap.set('n', 'gK', require('hover').hover_select, { desc='hover.nvim (select)' })

-- lspconfig
map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map("n", '<space>f', '<cmd>lua vim.lsp.buf.format{ async =true }<CR>', opts)
map('x', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting({})<CR>', opts)

-- trouble
map("n", "<space>t", "<cmd>TroubleToggle<cr>", opts)
map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)

-- barbar
  -- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
  -- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
  -- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- symbols-outline
map('n', '<A-s>', '<cmd>SymbolsOutline<CR>', opts)

-- illumniate
map('n', '<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', opts)
map('n', '<A-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', opts)

-- neo-tree
map('n', '<A-t>', '<cmd>Neotree toggle<CR>', opts)
