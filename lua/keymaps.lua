local opts = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

-- disable arrows
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)

-- window navigation
map('n', '<C-h>', '<cmd>wincmd h<cr>', opts)
map('n', '<C-j>', '<cmd>wincmd j<cr>', opts)
map('n', '<C-k>', '<cmd>wincmd k<cr>', opts)
map('n', '<C-l>', '<cmd>wincmd l<cr>', opts)

-- move
map('v', '<A-j>', ":m +1<cr>gv=gv", opts)
map('v', '<A-k>', ":m '<-2<cr>gv=gv", opts)
map('n', '<A-j>', "<cmd>m +1<cr>", opts)
map('n', '<A-k>', "<cmd>m -2<cr>", opts)
