local M = {}

-- plugin uri
M.uri = 'nvim-lualine/lualine.nvim'

-- plugin requirements
M.requirements = { 'nvim-tree/nvim-web-devicons' }

-- plugin configuration function
function M.configure()
  local colors = require('common.colors')
  local palette = colors.palette
  local util = require('common.util')

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand('%:p:h')
      local gitdir = vim.fn.finddir('.git', filepath .. ';')
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  -- Config
  local config = {
    options = {
      component_separators = '',
      section_separators = '',
      theme = {
        normal = { c = { fg = palette.fg, bg = palette.bg } },
        inactive = { c = { fg = palette.fg, bg = palette.bg } },
      },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  ins_left {
    function()
      return string.format(' %s', util.mode_label())
    end,
    color = function() return { bg = colors.mode_color(), fg = palette.bg } end,
    padding = { right = 1 },
  }

  ins_left {
    function()
      return string.format(' %s |', util.mode_alias())
    end,
    color = function() return { fg = colors.mode_color() } end,
    padding = { right = 1 },
  }

  ins_left {
    -- filesize component
    'filesize',
    cond = conditions.buffer_not_empty,
  }

  ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = palette.magenta, gui = 'bold' },
  }

  ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
      color_error = { fg = palette.red },
      color_warn = { fg = palette.yellow },
      color_info = { fg = palette.cyan },
    },
  }

  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  ins_left {
    function()
      return '%='
    end,
  }

  ins_left {
    -- Lsp server name .
    function()
      local msg = 'No Active Lsp'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return msg
    end,
    icon = ' LSP:',
    color = { fg = '#ffffff', gui = 'bold' },
  }

  -- Add components to right sections

  ins_right { 'location' }
  ins_right { 'progress', color = { fg = palette.fg, gui = 'bold' } }

  ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = palette.green, gui = 'bold' },
  }

  ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = palette.green, gui = 'bold' },
  }

  ins_right {
    'branch',
    icon = '',
    color = { fg = palette.magenta, gui = 'bold' },
  }

  ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = '柳 ', removed = ' ' },
    diff_color = {
      added = { fg = palette.green },
      modified = { fg = palette.orange },
      removed = { fg = palette.red },
    },
    cond = conditions.hide_in_width,
  }

  ins_right {
    function()
      return '▊'
    end,
    color = function() return { fg = colors.mode_color() } end,
    padding = { left = 1 },
  }

  require('lualine').setup(config)
end

return M
