local M = {}

-- plugin uri
M.uri = 'feline-nvim/feline.nvim'

M.dependencies = 'lewis6991/gitsigns.nvim'

-- plugin configuration function
function M.configure()
  local util = require('common.util')
  local lsp = require('common.lsp')
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
    right_sep = "block",
  }

  -- git branch
  C.git_branch = {
    provider = "git_branch",
    hl = { fg = colors.fg, bg = colors.darkblue, style = "bold" },
    icon = { str = ' ', hl = { fg = colors.primary_blue } },
    left_sep = "block",
    right_sep = "█",
  }

  -- git diff (add)
  C.git_add = {
    provider = "git_diff_added",
    icon = '  ',
    hl = { fg = colors.green },
    right_sep = { str = " ・", hl = { fg = colors.fg } },
  }

  -- git diff (delete)
  C.git_delete = {
    provider = "git_diff_removed",
    icon = ' ',
    hl = { fg = colors.red },
    right_sep = { str = " ・", hl = { fg = colors.fg } },
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
    icon = { str = ' ' },
    right_sep = "block",
    left_sep = "block",
  }

  -- lsp diag (warnings)
  C.diagnostic_warnings = {
    provider = "diagnostic_warnings",
    hl = { fg = colors.bg, bg = colors.orange },
    icon = { str = ' ' },
    right_sep = "block",
    left_sep = "block",
  }

  -- lsp diag (hints)
  C.diagnostic_hints = {
    provider = "diagnostic_hints",
    hl = { fg = colors.bg, bg = colors.blue },
    icon = { str = ' ' },
    right_sep = "block",
    left_sep = "block",
  }

  -- lsp diag (info)
  C.diagnostic_info = {
    provider = "diagnostic_info",
    hl = { fg = colors.bg, bg = colors.cyan },
    icon = { str = ' ' },
    right_sep = "block",
    left_sep = "block",
  }

  -- lsp info
  C.lsp = {
    provider = function()
      if not rawget(vim, "lsp") then
        return ""
      end

      local progress = vim.lsp.util.get_progress_messages()[1]

      if vim.o.columns < 120 then
        return ""
      end

      local clients = vim.lsp.get_active_clients({ bufnr = 0 })

      if #clients ~= 0 then
        if progress then
          local spinners = { "◜ ", "◠ ", "◝ ", "◞ ", "◡ ", "◟ " }
          local ms = vim.loop.hrtime() / 1000000
          local frame = math.floor(ms / 120) % #spinners
          local content = string.format("%%<%s", spinners[frame + 1])
          return content or ""
        else
          return "לּ " .. lsp.active_clients_formatted_names()
        end
      end
      return ""
    end,
    hl = function()
      local progress = vim.lsp.util.get_progress_messages()[1]
      return {
        fg = progress and "yellow" or "green",
        bg = colors.bg_highlight,
        style = "bold",
      }
    end,
    -- left_sep = " █",
    -- right_sep = "█ ",
    left_sep = "block",
    right_sep = "block",

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

      local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
      local position = math.floor(line_ratio * 100)

      if position <= 5 then
        return " TOP"
      elseif position >= 95 then
        return " BOT"
      else
        return chars[math.floor(line_ratio * #chars)] .. position
      end
    end,
    hl = {
      fg = colors.fg,
      bg = colors.bg_highlight,
      style = 'bold',
    },
    left_sep = "block",
    right_sep = "block",
  }

  -- encoding
  C.file_encoding = {
    provider = 'file_encoding',
    hl = { bg = colors.bg, style = 'bold' },
    left_sep = "block",
    right_sep = "block",
  }

  -- position
  C.position = {
    provider = 'position',
    padding = true,
    format = ' {line} ・ {col}',
    left_sep = "block",
    right_sep = "block",
  }

  -- file size
  C.file_size = {
    provider = 'file_size',
    hl = { bg = colors.darkblue },
    left_sep = "█",
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
          C.lsp,
          C.diagnostic_errors,
          C.diagnostic_warnings,
          C.diagnostic_hints,
          C.diagnostic_info,
          { hl = { gui = 'NONE' } }
        },

        -- right
        {
          C.position,
          C.file_encoding,
          C.file_size,
          C.scroll_bar,
          C.file_format
        }
      },
    },
    theme = colors,
    vi_mode_colors = colors.mode_colors,
  }
end

return M
