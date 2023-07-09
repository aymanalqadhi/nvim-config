local M = {}

-- plugin uri
M.uri = 'romgrk/barbar.nvim'

-- plugin dependencies
M.dependencies = {
  'lewis6991/gitsigns.nvim',
  'nvim-tree/nvim-web-devicons',
}

-- plugin configuration function
function M.configure()
  require 'barbar'.setup {
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,
    semantic_letters = true,
    focus_on_close = 'previous',
    -- hide = { extensions = true, inactive = true },

    -- highlighting
    highlight_alternate = false,
    highlight_inactive_file_icons = true,
    highlight_visible = true,

    -- icons
    icons = {
      buffer_index = false,
      buffer_number = false,
      button = '',

      -- lsp diagnostics
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = ' ' },
        [vim.diagnostic.severity.INFO] = { enabled = true, icon = ' ' },
        [vim.diagnostic.severity.HINT] = { enabled = true, icon = ' ' },
      },

      gitsigns = {
        added = { enabled = false, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = false, icon = '-' },
      },

      -- filetype icons
      filetype = {
        custom_colors = true,
        enabled = true,
      },

      -- separator
      --separator = { left = '▎', right = '' },
      separator = { left = ' ', right = ' ' },
      separator_at_end = false,

      -- indicators
      modified = { button = '●' },
      pinned = { button = '', filename = true },

      -- can be: 'default', 'powerline', or 'slanted'
      preset = 'default',

      -- custom buffer settings
      -- alternate = { filetype = { enabled = true } },
      -- current = { buffer_index = false, button = '' },
      -- inactive = { button = '×' },
      -- visible = { modified = { buffer_number = false } },
    },

    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = false,
    insert_at_start = false,

    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 30,
    minimum_length = 0,


    -- sidebar integration
    sidebar_filetypes = {
      NvimTree = true,
      ['neo-tree'] = { text = '               nullptr               ', event = 'BufWipeout' },
    },

    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    no_name_title = '<null_buffer>',
  }
end

-- keymaps
function M.set_keymaps(k)
  -- normal mode keys
  k.register({
    -- buffer navigation
    ["<A-,>"] = { "<cmd>BufferPrevious<cr>", "Previous Buffer" },
    ["<A-.>"] = { "<cmd>BufferNext<cr>", "Next Buffer" },

    -- buffer movement
    ["<A-<>"] = { "<cmd>BufferMovePrev<cr>", "Move Buffer Back" },
    ["<A->>"] = { "<cmd>BufferMoveNext<cr>", "Move Buffer Forward" },

    -- buffer jumping using index
    ["<A-1>"] = { "<cmd>BufferGoto 1<cr>", "Go-To Buffer #1" },
    ["<A-2>"] = { "<cmd>BufferGoto 2<cr>", "Go-To Buffer #2" },
    ["<A-3>"] = { "<cmd>BufferGoto 3<cr>", "Go-To Buffer #3" },
    ["<A-4>"] = { "<cmd>BufferGoto 4<cr>", "Go-To Buffer #4" },
    ["<A-5>"] = { "<cmd>BufferGoto 5<cr>", "Go-To Buffer #5" },
    ["<A-6>"] = { "<cmd>BufferGoto 6<cr>", "Go-To Buffer #6" },
    ["<A-7>"] = { "<cmd>BufferGoto 7<cr>", "Go-To Buffer #7" },
    ["<A-8>"] = { "<cmd>BufferGoto 8<cr>", "Go-To Buffer #8" },
    ["<A-9>"] = { "<cmd>BufferGoto 9<cr>", "Go-To Buffer #9" },

    -- buffer managment
    ["<A-p>"] = { "<cmd>BufferPin<cr>", "Pin Buffer" },
    ["<A-c>"] = { "<cmd>BufferClose<cr>", "Close Buffer" },
    ["<C-p>"] = { "<cmd>BufferPick<cr>", "Pick a Buffer" },
  })
end

return M
