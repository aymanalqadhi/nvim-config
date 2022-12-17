local M = {}

-- plugin uri
M.uri = 'akinsho/bufferline.nvim'

-- plugin requirements
M.requirements = { 'nvim-tree/nvim-web-devicons' }

-- plugin configuration function
function M.configure()
  require('bufferline').setup {
    options = {
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_buffer_default_icon = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      --separator_style = 'slant',
      always_show_bufferline = false,

      -- offsets
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'Files',
          separator = true,
        },
      },

      -- hover
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' }
      },

      -- lsp
      diagnostics = 'nvim_lsp',

      -- numbers
      numbers = function(opts)
        return string.format('%s', opts.raise(opts.ordinal))
      end,
    }
  }
end

-- keymaps
function M.keymaps()
  return {
    ["<C-p>"] = { "<cmd>BufferLinePick<cr>", "Pick a Buffer" },
    ["<A-.>"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
    ["<A-,>"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer" },
    ["<A-<>"] = { "<cmd>BufferLineMoveNext<cr>", "Move Forward" },
    ["<A->>"] = { "<cmd>BufferLineMovePrev<cr>", "Move Back" },
  }
end

return M
