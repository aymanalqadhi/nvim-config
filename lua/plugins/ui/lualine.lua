local M = {}

-- plugin uri
M.uri = 'nvim-lualine/lualine.nvim'

-- plugin dependencies
M.dependencies = { 'nvim-tree/nvim-web-devicons' }

-- plugin configuration function
function M.configure()
  local colors = require('common.colors')
  local palette = colors

  local util = require('common.util')
  local lsp = require('common.lsp')

  local conditions = {
    buffer_not_empty = function()
      return not vim.fn.empty(vim.fn.expand('%:t'))
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
        normal = {
          -- left
          a = function() return { fg = palette.bg, bg = colors.mode_color() } end,
          b = { fg = palette.fg, bg = palette.bg_highlight },
          c = { gui = 'bold' },
          -- middle
          x = {},
          -- right
          y = {},
          z = {},
        },
      }
    },
    sections = {
      lualine_a = { util.mode_label },
      lualine_b = {
        {
          'filetype',
          icon_only = true,
          padding = { left = 1, right = -1 },
        },
        {
          'filename',
          newfile_status = true,
          symbols = {
            modified = '',
            readonly = '',
            unnamed = '',
            newfile = '',
          },
        },
      },
      lualine_c = {
        {
          'branch',
          padding = { left = 1, right = 1 },
        },
        {
          'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
        },
        function() return '%=' end,
        {
          lsp.active_clients_formatted_names,
          cond = lsp.is_lsp_active,
          color = { bg = palette.bg_highlight, gui = 'bold' },
          icon = { '', color = { fg = palette.yellow } }
        },
      },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_workspace_diagnostic', 'nvim_diagnostic' },
          update_in_insert = false,
          always_visible = false,
        },
        function() return '%=' end,
        {
          'filesize',
          cond = conditions.buffer_not_empty,
          color = { fg = palette.green, gui = 'bold' }
        },
      },
      lualine_y = {
        {
          'progress',
          color = { gui = 'bold' },
        },
        { 'location' },
        {
          'o:encoding', -- option component same as &encoding in viml
          color = { bg = palette.bg_highlight }
        }
      },
      lualine_z = {
        {
          'hostname',
          color = function() return { fg = palette.bg, bg = colors.mode_color() } end,
        },
        {
          'fileformat',
          symbols = {
            unix = '',
            dos = '',
            mac = '',
          },
          padding = { left = 1, right = 1 },
          color = function() return { fg = palette.bg, bg = colors.mode_color() } end,
        }
      },
    },
    globalstatus = true,
    --always_divide_middle = true,
    extensions = {
      'man', 'nvim-tree', 'toggleterm'
    }
  }

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_a, component)
  end

  local function ins_mid1(component)
    table.insert(config.sections.lualine_c, component)
  end

  local function ins_mid2(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_z, component)
  end

  -- Add components to right sections

  require('lualine').setup(config)
end

return M
