local plugin = {}

-- plugin uri
plugin.uri = 'akinsho/bufferline.nvim'

-- plugin requirements
plugin.requires = { 'nvim-tree/nvim-web-devicons' }

-- plugin configuration function
function plugin.configure()
  require('bufferline').setup {
    options = {
      offsets = {
        {
          filetype = 'NvimTree',
          text = '',
          separator = true
        }
      },
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_buffer_default_icon = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = 'slant',
      always_show_bufferline = false,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' }
      },
    }
  }
end

return plugin
