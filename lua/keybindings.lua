local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- disable arrows
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)

-- telescope
map('n', ';f', '<cmd>Telescope find_files<cr>', opts)
--map('n', ';b', [[ <cmd>lua require('telescope.builtin').file_browser(require('telescope.themes').get_dropdown())<cr> ]], opts)
map('n', '\\\\', '<cmd>Telescope buffers theme=dropdown<cr>', opts)
map('n', ';;', '<cmd>Telescope help_tags theme=dropdown<cr>', opts)
--map('n', ' .', '<cmd>Telescope lsp_code_actions<cr>', opts)
map('n', ';s', '<cmd>Telescope live_grep theme=dropdown<cr>', opts)
map('n', ';r', '<cmd>Telescope grep_string theme=dropdown<cr>', opts)

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
map('n', 'K', require('hover').hover, opts)
map('n', 'gK', require('hover').hover_select, opts)

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
map('', '<space>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map("n", '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
map('x', '<space>f', '<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>', opts)
map('n', '<space>s', '<cmd>Telescope spell_suggest theme=dropdown<CR>', opts)

-- trouble
map("n", "<space>tt", "<cmd>TroubleToggle<cr>", opts)
map("n", "<space>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
map("n", "<space>td", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
map("n", "<space>tl", "<cmd>TroubleToggle loclist<cr>", opts)
map("n", "<space>t.", "<cmd>TroubleToggle quickfix<cr>", opts)
map("n", "<space>tr", "<cmd>TroubleRefresh<cr>", opts)
map("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)
map("n", "[t", [[ <cmd>lua require("trouble").previous{skip_groups = true, jump = true}<cr> ]], opts)
map("n", "]t", [[ <cmd>lua require("trouble").next{skip_groups = true, jump = true}<cr> ]], opts)

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
map('n', '<A-t>', '<cmd>NvimTreeToggle<CR>', opts)

-- codewindow
map('n', ';m', require 'codewindow'.toggle_minimap, opts)
map('n', ';M', require 'codewindow'.toggle_focus, opts)

-- toggleterm
map('t', '<esc>', [[<C-\><C-n>]], opts)
map('t', 'jk', [[<C-\><C-n>]], opts)
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

_G.lazygit = require('toggleterm.terminal').Terminal:new({
  cmd = 'lazygit',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  on_open = function(term)
    vim.cmd('startinsert!')
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', opts)
  end,
})

vim.keymap.set('n', '<space>g', [[ <cmd>lua _G.lazygit:toggle()<CR> ]], opts)

-- dap
map('n', ',b', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
map('n', ',c', "<cmd>lua require'dap'.continue()<CR>", opts)
map('n', ',r', "<cmd>lua require'dap'.repl.open()<CR>", opts)
map('n', ',i', "<cmd>lua require'dap'.step_in()<CR>", opts)
map('n', ',o', "<cmd>lua require'dap'.step_over()<CR>", opts)
map('n', ',t', "<cmd>lua require'dap'.terminate()<CR>", opts)
map('n', ',u', "<cmd>lua require'dapui'.toggle() <CR>", opts)
map('n', ',e', "<cmd>lua require'dapui'.eval()<CR>", opts)

-- folding (ufo)
map('n', 'zR', require('ufo').openAllFolds)
map('n', 'zM', require('ufo').closeAllFolds)
map('n', 'zr', require('ufo').openFoldsExceptKinds)
map('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
map('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, opts)
