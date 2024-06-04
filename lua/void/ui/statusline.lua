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
            newfile_status = true,
            path = 1,
            shorting_target = 48,
            symbols = {
              modified = "",
              readonly = "",
              unnamed = " 󰍛",
              newfile = "",
            },
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
        "toggleterm",
        "nvim-tree",
        "lazy",
      },
    })

    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        require("lualine").refresh({ place = { "statusline" } })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            require("lualine").refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
    })
  end,
}
