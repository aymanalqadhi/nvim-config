return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = function(_, opts)
    local icons = require("config.icons")
    local utl = require("plugins.ui.lualine.util")

    vim.o.laststatus = vim.g.lualine_laststatus

    local new_opts = {
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
            fmt = utl.format_mode,
            padding = 0,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = icons.misc.branch,
          },
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
            path = 4,
            symbols = icons.file,
          },
          {
            "diff",
            symbols = icons.git,
          },
          {
            utl.macro_label,
            icon = icons.misc.record,
            color = "Constant",
          },
        },
        lualine_x = {
          utl.noice_component("command", "Comment"),
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
          },
          {
            utl.lsp_clients_string,
            fmt = function(x)
              return " " .. x
            end,
            icon = { icons.misc.engine, color = "DiagnosticOk" },
            color = { gui = "bold" },
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = "Comment",
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
    }

    return vim.tbl_deep_extend("force", opts, new_opts)
  end,

  init = function()
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
