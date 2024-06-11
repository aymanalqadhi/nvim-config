return {
  "nvim-lualine/lualine.nvim",

  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    vim.o.laststatus = vim.g.lualine_laststatus

    local modes = {
      NORMAL = "  ",
      INSERT = "  ",
      VISUAL = " 󰘖 ",
      ["V-LINE"] = " 󰡏 ",
      ["V-BLOCK"] = " 󰁌 ",
      REPLACE = "  ",
      ["V-REPLACE"] = "  ",
      ENTER = "  ",
      MORE = "  ",
      SELECT = "  ",
      COMMAND = "  ",
      SHELL = "  ",
      TERM = "  ",
      NONE = " ⏺︎ ",
      CONFIRM = " ᐅ ",
      TERMINAL = " $ ",
    }

    local status_symbols = {
      modified = " ",
      readonly = "",
      unnamed = " 󰍛",
      newfile = "",
      directory = "",
      alternate_file = "",
    }

    require("lualine").setup({
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
          { "branch", icon = "" },
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
              added    = " ",
              modified = " ",
              removed  = " ",
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
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

              return " " .. table.concat(names, ", ")
            end,
            color = { gui = "bold" },
          },
          {
            function()
              local reg = vim.fn.reg_recording()
              if reg == "" then
                return ""
              end
              return "REC @" .. reg
            end,
            icon = "󰑋",
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
    })

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
