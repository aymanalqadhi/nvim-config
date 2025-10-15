void.keymap.set({
  -- window navigation
  { "<c-h>", "<c-w><c-h>", desc = "win: left" },
  { "<c-j>", "<c-w><c-j>", desc = "win: down" },
  { "<c-k>", "<c-w><c-k>", desc = "win: up" },
  { "<c-l>", "<c-w><c-l>", desc = "win: right" },

  -- window resizing
  { "<c-right>", "<cmd>vert resize +1<cr>", desc = "win: wider" },
  { "<c-left>", "<cmd>vert resize -1<cr>", desc = "win: narrower" },
  { "<c-up>", "<cmd>resize +1<cr>", desc = "win: taller" },
  { "<c-down>", "<cmd>resize -1<cr>", desc = "win: shorter" },

  -- window management
  { "<leader>-", "<cmd>split<cr>", desc = "win: split below" },
  { "<leader>|", "<cmd>vsplit<cr>", desc = "win: split right" },
  { "<leader>wq", "<cmd>quit<cr>", desc = "win: quit" },
  { "<leader>wc", "<cmd>close<cr>", desc = "win: close" },
  { "<leader>wo", "<cmd>only<cr>", desc = "win: only" },
  { "<leader>we", "<cmd>wincmd =<cr>", desc = "win: equalize" },

  -- buffers
  { "[b", "<cmd>bprevious<cr>", desc = "buf: prev" },
  { "]b", "<cmd>bnext<cr>", desc = "buf: next" },
  { "<leader>bd", void.buf.delete, desc = "buf: delete" },
  {
    "<leader>bD",
    function()
      void.buf.delete({ force = true })
    end,
    desc = "buf: force delete",
  },
  { "<leader>bo", void.buf.other, desc = "buf: delete others" },
  { "<leader>ba", "<cmd>ball<cr>", desc = "buf: all" },

  -- tabs
  { "[T", "<cmd>tabprevious<cr>", desc = "tab: prev" },
  { "]T", "<cmd>tabnext<cr>", desc = "tab: next" },
  { "<leader>T", "<cmd>tabnew<cr>", desc = "tab: new" },
  { "<leader>Td", "<cmd>tabclose<cr>", desc = "tab: close" },
  { "<leader>To", "<cmd>tabonly<cr>", desc = "tab: close others" },

  -- clear `hlsearch` with `esc`
  { "<esc>", "<cmd>nohlsearch<cr><esc>", desc = "clear `hlsearch`" },

  -- better visual-mode indentation
  { "<", "<gv", desc = "indent: left", mode = { "v" } },
  { ">", ">gv", desc = "indent: right", mode = { "v" } },

  -- move lines
  { "<m-j>", "<cmd>m .+1<cr>==", desc = "move line down" },
  { "<m-k>", "<cmd>m .-2<cr>==", desc = "move line up" },
  { "<m-j>", "<esc><cmd>m .+1<cr>==gi", desc = "move line down", mode = { "i" } },
  { "<m-k>", "<esc><cmd>m .-2<cr>==gi", desc = "move line up", mode = { "i" } },
  { "<m-j>", ":m '>+1<cr>gv=gv", desc = "move selection down", mode = { "v" } },
  { "<m-k>", ":m '<-2<cr>gv=gv", desc = "move selection up", mode = { "v" } },

  -- diagnostics
  { "gd", vim.diagnostic.open_float, desc = "diagnostic: show float" },
  {
    "[d",
    function()
      vim.diagnostic.jump({ count = -1 })
    end,
    desc = "diagnostic: goto prev",
  },
  {
    "]d",
    function()
      vim.diagnostic.jump({ count = 1 })
    end,
    desc = "diagnostic: goto next",
  },
})

-- terminal mappings
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    void.keymap.buf_set(0, {
      { "<esc><esc>", [[<c-\><c-n>]], desc = "term: leave", mode = { "t" } },
      { "<c-[><c-[>", [[<c-\><c-n>]], desc = "term: leave", mode = { "t" } },
      { "<c-h>", "<cmd>wincmd h<cr>", desc = "term: left", mode = { "t" } },
      { "<c-j>", "<cmd>wincmd j<cr>", desc = "term: down", mode = { "t" } },
      { "<c-k>", "<cmd>wincmd k<cr>", desc = "term: up", mode = { "t" } },
      { "<c-l>", "<cmd>wincmd l<cr>", desc = "term: right", mode = { "t" } },
    })
  end,
})
