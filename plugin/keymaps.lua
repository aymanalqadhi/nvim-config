local set = vim.keymap.set

-- window navigation
set("n", "<c-h>", "<c-w><c-h>", { desc = "left window" })
set("n", "<c-j>", "<c-w><c-j>", { desc = "lower window" })
set("n", "<c-k>", "<c-w><c-k>", { desc = "upper window" })
set("n", "<c-l>", "<c-w><c-l>", { desc = "right window" })

-- window resizing
set("n", "<c-left>", "<cmd>vert resize 1<cr>", { desc = "shrink window" })
set("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "shorten window" })
set("n", "<c-up>", "<cmd>resize +3<cr>", { desc = "longen window" })
set("n", "<c-right>", "<cmd>vert resize +2<cr>", { desc = "widen window" })

-- buffer navigation
set("n", "[b", "<cmd>bnext<cr>", { desc = "prev buffer" })
set("n", "]b", "<cmd>bprevious<cr>", { desc = "next buffer" })

-- buffer managemenet
set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "prev buffer" })
set("n", "<leader>ba", "<cmd>ball<cr>", { desc = "prev buffer" })

-- clear `hlsearch` with `esc`
set({ "n", "i" }, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "clear `hlsearch`" })

-- better visual-mode indentation
set("v", "<", "<gv", { desc = "indent left" })
set("v", ">", ">gv", { desc = "indent right" })

-- move lines
set("n", "<m-j>", "<cmd>m .+1<cr>==", { desc = "move line down" })
set("n", "<m-k>", "<cmd>m .-2<cr>==", { desc = "move line up" })
set("i", "<m-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "move line down" })
set("i", "<m-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "move line up" })
set("v", "<m-j>", ":m '>+1<cr>gv=gv", { desc = "move selection down" })
set("v", "<m-k>", ":m '<-2<cr>gv=gv", { desc = "move selection up" })

-- terminal
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }

  set("t", "<esc><esc>", "<c-\\><c-n>", opts)
  set("t", "<c-h>", "<cmd>wincmd h<cr>", opts)
  set("t", "<c-j>", "<cmd>wincmd j<cr>", opts)
  set("t", "<c-k>", "<cmd>wincmd k<cr>", opts)
  set("t", "<c-l>", "<cmd>wincmd l<cr>", opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
