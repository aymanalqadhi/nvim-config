local M = {}

-- plugin uri
M.uri = 'freddiehaddad/feline.nvim'

-- plugin configuration function
function M.configure()
  local util = require('common.util')
  local colors = require('common.colors')
  local icons = require('common.icons').lsp_kinds

  -- cache hostname value
  local hostname = ' ' .. vim.loop.os_gethostname() .. ' '

  -- components map
  local C = {}

  -- mode
  C.vim_mode = {
    provider = util.mode_label,
    hl = function()
      return {
        fg = colors.bg,
        bg = colors.mode_color(),
        style = 'bold',
      }
    end,
  }

  -- file info
  C.file_info = {
    provider = 'file_info',
    hl = { bg = colors.bg_highlight, },
    file_readonly_icon = '',
    left_sep = 'block',
    right_sep = ' ',
  }

  -- git branch
  C.git_branch = {
    provider = 'git_branch',
    hl = { fg = colors.fg, bg = colors.darkblue, style = 'bold' },
    icon = { str = ' ', hl = { fg = colors.primary_blue } },
    left_sep = 'left_rounded',
    right_sep = ' ',
  }

  -- git diff (add)
  C.git_add = {
    provider = 'git_diff_added',
    icon = '  ',
    hl = { fg = colors.green },
    right_sep = { str = '・', hl = { fg = colors.fg } },
  }

  -- git diff (delete)
  C.git_delete = {
    provider = 'git_diff_removed',
    icon = ' ',
    hl = { fg = colors.red },
    right_sep = { str = '・', hl = { fg = colors.fg } },
  }

  -- git diff (change)
  C.git_change = {
    provider = 'git_diff_changed',
    icon = ' ',
    hl = { fg = colors.yellow },
  }

  -- lsp diag (errors)
  C.diagnostic_errors = {
    provider = 'diagnostic_errors',
    hl = { fg = colors.bg, bg = colors.red },
    icon = { str = ' ' },
    left_sep = 'left_rounded',
    right_sep = ' ',
  }

  -- lsp diag (warnings)
  C.diagnostic_warnings = {
    provider = 'diagnostic_warnings',
    hl = { fg = colors.bg, bg = colors.orange },
    icon = { str = ' ' },
    left_sep = 'left_rounded',
    right_sep = ' ',
  }

  -- lsp diag (hints)
  C.diagnostic_hints = {
    provider = 'diagnostic_hints',
    hl = { fg = colors.bg, bg = colors.blue },
    icon = { str = ' ' },
    left_sep = 'left_rounded',
    right_sep = ' ',
  }

  -- lsp diag (info)
  C.diagnostic_info = {
    provider = 'diagnostic_info',
    hl = { fg = colors.bg, bg = colors.cyan },
    icon = { str = ' ' },
    left_sep = 'left_rounded',
    right_sep = 'right_rounded',
  }

  -- lsp clients
  C.lsp_client_names = {
    provider = function()
      local clients = vim.lsp.buf_get_clients()
      local names = {}

      for _, client in pairs(clients) do
        table.insert(names, client.name)
      end

      return table.concat(names, ', ')
    end,
    hl = { bg = colors.bg_highlight, style = 'bold' },
    icon = { str = icons.Lsp, hl = { fg = colors.yellow } },
    left_sep = 'left_rounded',
    right_sep = ' ',
    update = { 'LspAttach', 'LspDetach' },
  }

  -- file format by platform
  C.hostname = {
    provider = hostname,
    hl = function()
      return { fg = colors.bg, bg = colors.mode_color(), style = 'bold' }
    end,
    update = false,
  }

  -- scroll_bar
  C.scroll_bar = {
    provider = function()
      local chars = {
        ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ',
      }

      local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
      local line_ratio = math.floor((row / vim.api.nvim_buf_line_count(0)) * 100)

      if line_ratio <= 5 then
        return ' TOP'
      elseif line_ratio >= 95 then
        return ' BOT'
      else
        return chars[math.floor((line_ratio / 100) * #chars)] .. line_ratio .. '%%'
      end
    end,
    hl = {
      fg = colors.fg,
      bg = colors.bg_highlight,
      style = 'bold',
    },
    left_sep = ' ',
    right_sep = 'block',
  }

  -- encoding
  C.file_encoding = {
    provider = 'file_encoding',
    hl = { bg = colors.darkblue, style = 'bold' },
    left_sep = ' ',
    right_sep = 'right_rounded',
  }

  -- file size
  C.file_size = {
    provider = 'file_size',
    hl = { bg = colors.none, fg = colors.green },
  }

  -- '@recording'
  local loaded, noice = pcall(require, 'noice')

  if loaded and noice ~= nil then
    C.macro_indicator = {
      provider = function()
        if not noice.api.statusline.mode.has() then
          return ''
        end

        local mode = noice.api.statusline.mode.get()
        local _, _, reg = mode:find('@([0-9A-Za-z]+)')

        return reg or ''
      end,
      hl = { fg = colors.bg_dark, bg = colors.orange, style = 'bold' },
      icon = { str = '󰑋 ', hl = { fg = colors.bg_dark } },
      left_sep = 'left_rounded',
      right_sep = '  ',
    }
  else
    C.macro_indicator = nil
  end

  require('feline').setup {
    disable = {
      buftypes = {
        'nofile',
      },
    },
    components = {
      active = {
        -- left
        {
          C.vim_mode,
          C.file_info,
          C.git_branch,
          C.git_add,
          C.git_delete,
          C.git_change,
        },

        -- middle
        {
          C.lsp_client_names,
          C.diagnostic_errors,
          C.diagnostic_warnings,
          C.diagnostic_hints,
          C.diagnostic_info,
          { hl = { bg = colors.none } }
        },

        -- right
        {
          C.macro_indicator,
          C.file_size,
          C.file_encoding,
          C.scroll_bar,
          C.hostname
        }
      },
      inactive = {
        -- left
        {
          C.file_info,
          C.git_add,
          C.git_delete,
          C.git_change,
        },
        -- right
        {
          C.scroll_bar,
        }
      }
    },
    theme = {
      bg = colors.none,
      fg = colors.fg
    },
    vi_mode_colors = colors.mode_colors,
  }
end

return M
