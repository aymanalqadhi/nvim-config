local M = {}

-- plugin uri
M.uri = 'freddiehaddad/feline.nvim'

-- plugin configuration function
function M.configure()
  local util = require('common.util')
  local colors = require('common.colors')

  -- components map
  local C = {}

  -- mode
  C.vim_mode = {
    provider = util.mode_label,
    hl = function()
      return {
        fg = "bg",
        bg = colors.mode_color(),
        style = "bold",
      }
    end,
  }

  -- file info
  C.file_info = {
    provider = 'file_info',
    hl = { bg = colors.bg_highlight },
    file_readonly_icon = '',
    left_sep = "block",
    right_sep = " ",
  }

  -- git branch
  C.git_branch = {
    provider = "git_branch",
    hl = { fg = colors.fg, bg = colors.darkblue, style = "bold" },
    icon = { str = ' ', hl = { fg = colors.primary_blue } },
    left_sep = "left_rounded",
    right_sep = " ",
  }

  -- git diff (add)
  C.git_add = {
    provider = "git_diff_added",
    icon = '  ',
    hl = { fg = colors.green },
    right_sep = { str = "・", hl = { fg = colors.fg } },
  }

  -- git diff (delete)
  C.git_delete = {
    provider = "git_diff_removed",
    icon = ' ',
    hl = { fg = colors.red },
    right_sep = { str = "・", hl = { fg = colors.fg } },
  }

  -- git diff (change)
  C.git_change = {
    provider = "git_diff_changed",
    icon = ' ',
    hl = { fg = colors.yellow },
  }

  -- lsp diag (errors)
  C.diagnostic_errors = {
    provider = "diagnostic_errors",
    hl = { fg = colors.bg, bg = colors.red },
    icon = { str = ' ' },
    left_sep = "left_rounded",
    right_sep = " ",
  }

  -- lsp diag (warnings)
  C.diagnostic_warnings = {
    provider = "diagnostic_warnings",
    hl = { fg = colors.bg, bg = colors.orange },
    icon = { str = ' ' },
    left_sep = "left_rounded",
    right_sep = " ",
  }

  -- lsp diag (hints)
  C.diagnostic_hints = {
    provider = "diagnostic_hints",
    hl = { fg = colors.bg, bg = colors.blue },
    icon = { str = ' ' },
    left_sep = "left_rounded",
    right_sep = " ",
  }

  -- lsp diag (info)
  C.diagnostic_info = {
    provider = "diagnostic_info",
    hl = { fg = colors.bg, bg = colors.cyan },
    icon = { str = ' ' },
    left_sep = "left_rounded",
    right_sep = "right_rounded",
  }

  -- lsp clients
  C.lsp_client_names = {
    provider = "lsp_client_names",
    hl = { bg = colors.bg_highlight, style = 'bold' },
    icon = { str = ' ', hl = { fg = colors.yellow } },
    left_sep = "left_rounded",
    right_sep = " ",
  }

  -- file format by platform
  C.file_format = {
    provider = function()
      if vim.bo.fileformat == 'unix' then
        return '  '
      elseif vim.bo.fileformat == 'mac' then
        return '  '
      else
        return '  '
      end
    end,
    hl = function()
      return { fg = "bg", bg = colors.mode_color() }
    end,
  }

  -- scroll_bar
  C.scroll_bar = {
    provider = function()
      local chars = {
        " ", " ", " ", " ", " ", " ", " ",
        " ", " ", " ", " ", " ", " ", " ",
        " ", " ", " ", " ", " ", " ", " ",
        " ", " ", " ", " ", " ", " ", " ",
      }

      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local position = row .. '・' .. col

      local line_ratio = math.floor((row / vim.api.nvim_buf_line_count(0)) * 100)
      local approx = ''

      if line_ratio <= 5 then
        approx = " TOP"
      elseif line_ratio >= 95 then
        approx = " BOT"
      else
        approx = chars[math.floor((line_ratio / 100) * #chars)] .. line_ratio
      end

      return approx .. '  ' .. position
    end,
    hl = {
      fg = colors.fg,
      bg = colors.bg_highlight,
      style = 'bold',
    },
    left_sep = " ",
    right_sep = "block",
  }

  -- encoding
  C.file_encoding = {
    provider = 'file_encoding',
    hl = { bg = colors.darkblue, style = 'bold' },
    left_sep = " ",
    right_sep = "right_rounded",
  }

  -- file size
  C.file_size = {
    provider = 'file_size',
    hl = { bg = colors.bg, fg = colors.green },
    left_sep = "block",
    right_sep = "block",
  }

  require('feline').setup {
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
          { hl = { bg = colors.bg } }
        },

        -- right
        {
          C.file_size,
          C.file_encoding,
          C.scroll_bar,
          C.file_format
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
    theme = colors,
    vi_mode_colors = colors.mode_colors,
  }
end

return M
