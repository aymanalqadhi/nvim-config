-- register keybindings
Void.core.keys.register_many({
  -- better up/down
  {
    j = { "v:count == 0 ? 'gj' : 'j'", "Up" },
    k = { "v:count == 0 ? 'gk' : 'k'", "Up" },
    mode = { "n", "x" },
    opts = { expr = true },
  },

  -- hjkl window movement
  {
    ["<C-h>"] = { "<C-w>h", "Go to left window" },
    ["<C-j>"] = { "<C-w>j", "Go to lower window" },
    ["<C-k>"] = { "<C-w>k", "Go to upper window" },
    ["<C-l>"] = { "<C-w>l", "Go to right window" },
    mode = "n",
  },

  -- window resizing
  {
    ["<C-Up>"] = { "<cmd>resize +2<cr>", "Increase window height" },
    ["<C-Down>"] = { "<cmd>resize -2<cr>", "Decrease window height" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<cr>", "Decrease window width" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<cr>", "Increase window width" },
    mode = "n",
  },

  -- window management
  {
    ww = { "<cmd>wincmd p<cr>", "Other window" },
    wd = { "<cmd>wincmd c<cr>", "Close window" },
    wx = { "<cmd>wincmd x<cr>", "Switch windows" },
    wq = { "<cmd>q<cr>", "Quit" },
    ["-"] = { "<cmd>wincmd s<cr>", "Split window below" },
    ["|"] = { "<cmd>wincmd v<cr>", "Split window right" },
    ["="] = { "<cmd>wincmd =<cr>", "Justify windows" },

    prefix = "<leader>",
    opts = { silent = true, remap = true },
  },

  -- terminal keymaps
  {
    ["<esc>"] = { "<C-\\><C-n>", "Escape terminal mode" },
    ["<C-h>"] = { "<cmd>wincmd h<cr>", "Go to left window" },
    ["<C-j>"] = { "<cmd>wincmd j<cr>", "Go to lower window" },
    ["<C-k>"] = { "<cmd>wincmd k<cr>", "Go to upper window" },
    ["<C-l>"] = { "<cmd>wincmd l<cr>", "Go to right window" },
    -- ["<C-w>"] = { "<C-\\><C-n><C-w>", "Escape terminal mode" },

    mode = "t",
  },

  -- move lines
  {
    {
      ["<A-j>"] = { "<cmd>m .+1<cr>==", "Move down" },
      ["<A-k>"] = { "<cmd>m .-2<cr>==", "Move up" },
      mode = "n",
    },
    {
      ["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "Move down" },
      ["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "Move up" },
      mode = "i",
    },
    {
      ["<A-j>"] = { ":m '>+1<cr>gv=gv", "Move down" },
      ["<A-k>"] = { ":m '<-2<cr>gv=gv", "Move up" },
      mode = "v",
    },
  },

  -- clear search with <esc>
  {
    ["<esc>"] = { "<cmd>noh<cr><esc>", "Escape and clear hlsearch" },
    mode = { "i", "n" },
  },

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  {
    {
      n = { "'Nn'[v:searchforward].'zv'", "Next search result" },
      N = { "'nN'[v:searchforward].'zv'", "Prev search result" },
      mode = "n",
    },
    {
      n = { "'Nn'[v:searchforward]", "Next search result" },
      N = { "'nN'[v:searchforward]", "Prev search result" },
      mode = { "x", "o" },
    },
    opts = { expr = true },
  },

  -- keywordprg
  {
    ["<leader>K"] = { "<cmd>norm! K<cr>", "Keywordprg" },
    mode = "n",
  },

  -- better indentations
  {
    ["<"] = "<gv",
    [">"] = ">gv",
    mode = "v",
  },
})
