return {
  "nvim-lualine/lualine.nvim",

  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = function()
    local icons = void.config.icons

    local modes = {
      COMMAND       = icons.modes.Command,
      INSERT        = icons.modes.Insert,
      NORMAL        = icons.modes.Normal,
      REPLACE       = icons.modes.Replace,
      ["V-REPLACE"] = icons.modes.ReplaceVirtual,
      SELECT        = icons.modes.Select,
      TERMINAL      = icons.modes.Terminal,
      VISUAL        = icons.modes.Visual,
      ["V-LINE"]    = icons.modes.VisualLine,
      ["V-BLOCK"]   = icons.modes.VisualBlock,
      CONFIRM       = icons.modes.Confirm,
      ENTER         = icons.modes.Enter,
      MORE          = icons.modes.More,
      SHELL         = icons.modes.Shell,
    }

    local status_symbols = {
      modified       = " " .. icons.buffer.Modified,
      readonly       = " " .. icons.buffer.Readonly,
      unnamed        = " " .. icons.buffer.Unnamed,
      newfile        = " " .. icons.buffer.NewFile,
      directory      = " " .. icons.buffer.Directory,
      alternate_file = "",
    }

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "starter" },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },

      tabline = {
        lualine_a = {
          {
            "buffers",
            symbols = status_symbols,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "encoding" },
        lualine_z = {
          {
            "tabs",
            show_modified_status = false,
          },
        }
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(mode) return modes[mode] or mode end,
            padding = 0,
          },
        },
        lualine_b = {
          { "branch", icon = icons.git.Branch },
        },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            -- newfile_status = true,
            path = 1,
            shorting_target = 48,
            symbols = status_symbols,
            padding = { left = 0, right = 1 },
          },
          {
            "diff",
            symbols = {
              added    = icons.git.Added,
              modified = icons.git.Modified,
              removed  = icons.git.Removed,
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
            symbols = {
              error = icons.diagnostics.signs.Error,
              warn  = icons.diagnostics.signs.Warning,
              info  = icons.diagnostics.signs.Info,
              hint  = icons.diagnostics.signs.Hint,
            },
          },
          {
            function()
              local clients = vim.lsp.get_clients()
              if #clients == 0 then
                return ""
              end

              local names = {}
              for _, client in pairs(clients) do
                table.insert(names, client.name)
              end

              return icons.Cog .. " " .. table.concat(names, ", ")
            end,
            color = { gui = "bold" },
          },
          {
            function()
              local reg = vim.fn.reg_recording()
              return #reg > 0 and "REC @" .. reg or ""
            end,
            icon = icons.Recording,
            color = "Constant",
          },
        },
        lualine_y = {
          {
            "progress",
            padding = { left = 1, right = 0 },
            color = { gui = "bold" },
          },
          {
            "location",
            fmt = function(str)
              return str:gsub("%s+", "")
            end,
          },
        },
        lualine_z = {
          {
            "fileformat",
          },
        },
      },
      extensions = {
        "quickfix",
        "lazy",
        "nvim-dap-ui",
        "oil",
      },
    }
  end,

  config = function(_, opts)
    vim.o.laststatus = vim.g.lualine_laststatus

    require("lualine").setup(opts)

    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        vim.schedule(function()
          require("lualine").refresh({ place = { "statusline" } })
        end)
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        vim.schedule(function()
          require("lualine").refresh({ place = { "statusline" } })
        end)
      end,
    })
  end,
}
