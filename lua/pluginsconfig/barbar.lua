local barbar = require('bufferline')
local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local function get_tree_size()
  return require 'nvim-tree.view'.View.width
end

local function configure()
  barbar.setup {
    animation = true,
    auto_hide = true,

    tabpages = true,
    closable = true,
    clickable = true,

    icons = true,
    icon_custom_colors = true,
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = '✕',
    icon_close_tab_modified = '●',
    icon_pinned = '車',

    insert_at_end = false,
    insert_at_start = false,

    maximum_padding = 1,
    maximum_length = 30,
    semantic_letters = true,
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
    no_name_title = ' -- void -- ',
  }

  vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = 'none' })

  nvim_tree_events.subscribe('TreeOpen', function()
    bufferline_api.set_offset(get_tree_size())
  end)

  nvim_tree_events.subscribe('Resize', function()
    bufferline_api.set_offset(get_tree_size())
  end)

  nvim_tree_events.subscribe('TreeClose', function()
    bufferline_api.set_offset(0)
  end)
end

return {
  configure = configure
}
