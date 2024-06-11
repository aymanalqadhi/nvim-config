return {
  "nvim-tree/nvim-tree.lua",

  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,

  keys = {
    { "<A-t>", "<cmd>NvimTreeToggle<cr>" },
  },

  opts = {
    sync_root_with_cwd = true,
    select_prompts = true,

    -- native features hijack
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,

    -- exclusions
    filters = { dotfiles = false },

    -- file watching
    filesystem_watchers = {
      enable = true,
    },

    -- dynamic window width
    actions = {
      open_file = {
        resize_window = true,
      },
    },

    -- git integration
    git = {
      enable = false,
      ignore = true,
    },

    -- search
    live_filter = {
      prefix = " ",
      always_show_folders = true,
    },

    -- diagnostics
    diagnostics = { enable = true },

    -- follow opened file
    update_focused_file = {
      enable = true,
      update_root = false,
    },

    -- appearance
    view = {
      width = {
        min = 32,
        max = 48,
      },

      float = {
        enable = true,
        open_win_config = {
          relative = "editor",
          border = "none",
          width = 32,
          height = 80,
          row = 0,
          col = 0,
        },
      },

      preserve_window_proportions = true,
      signcolumn = "auto",
    },

    renderer = {
      root_folder_label = false,
      root_folder_modifier = ":t",

      highlight_git = true,
      -- highlight_opened_files = "name",
      highlight_diagnostics = true,

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
        },

        web_devicons = {
          folder = {
            enable = true,
            color = true,
          },
        },

        glyphs = {
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },

      -- disable indent markers
      indent_markers = {
        enable = false,
      },
    },
  },
}
