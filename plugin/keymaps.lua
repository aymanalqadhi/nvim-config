local set = vim.keymap.set

-- window navigation
set("n", "<c-h>", "<c-w><c-h>", { desc = "win: left" })
set("n", "<c-j>", "<c-w><c-j>", { desc = "win: down" })
set("n", "<c-k>", "<c-w><c-k>", { desc = "win: up" })
set("n", "<c-l>", "<c-w><c-l>", { desc = "win: right" })

-- window resizing
set("n", "<c-left>", "<cmd>vert resize 1<cr>", { desc = "win: narrower" })
set("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "win: shorter" })
set("n", "<c-up>", "<cmd>resize +3<cr>", { desc = "win: taller" })
set("n", "<c-right>", "<cmd>vert resize +2<cr>", { desc = "win: wider" })

-- window management
set("n", "<leader>ws", "<cmd>split<cr>", { desc = "win: split below" })
set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "win: split right" })
set("n", "<leader>wq", "<cmd>quit<cr>", { desc = "win: quit" })
set("n", "<leader>wc", "<cmd>close<cr>", { desc = "win: close" })
set("n", "<leader>wo", "<cmd>only<cr>", { desc = "win: only" })
set("n", "<leader>we", "<cmd>wincmd =<cr>", { desc = "win: equalize" })

-- buffer navigation
set("n", "[b", "<cmd>bprevious<cr>", { desc = "buf: prev" })
set("n", "]b", "<cmd>bnext<cr>", { desc = "buf: next" })

-- buffer managemenet
set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "buf: delete" })
set("n", "<leader>ba", "<cmd>ball<cr>", { desc = "buf: all" })

-- clear `hlsearch` with `esc`
set({ "n", "i" }, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "clear `hlsearch`" })

-- better visual-mode indentation
set("v", "<", "<gv", { desc = "indent: left" })
set("v", ">", ">gv", { desc = "indent: right" })

-- better command mode
set("c", "<c-a>", "<home>")
set("c", "<c-b>", "<left>")
set("c", "<c-d>", "<del>")
set("c", "<c-e>", "<end>")
set("c", "<c-f>", "<right>")
set("c", "<c-n>", "<down>")
set("c", "<c-p>", "<up>")
set("c", "<esc><c-b>", "<s-left>")
set("c", "<esc><c-f>", "<s-right>")

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
