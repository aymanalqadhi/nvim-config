local nvtree = require("nvim-tree")

local function configure()

  local config = {
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = true,
    open_on_setup_file = true,
    sort_by = "name",
    root_dirs = {},
    --prefer_startup_root = true,
    --sync_root_with_cwd = true,
    --reload_on_bufenter = true,
    select_prompts = true,

    view = {
      --adaptive_size = true,
      centralize_selection = true,
      width = 40,
      hide_root_folder = false,
      signcolumn = "yes",

      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },

    renderer = {
      highlight_git = true,
      highlight_opened_files = "all",
      root_folder_modifier = ":~",
      indent_width = 2,

      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
      special_files = {
        "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt",
        "packages.json",
      },
    },
    update_focused_file = {
      enable = true,
      ignore_list = {},
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      debounce_delay = 50,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    filters = {
      dotfiles = true,
      custom = {
        "target", "node_modules", "build", "bin", "obj",
      },
      exclude = {},
    },
    git = {
      enable = true,
      ignore = true,
      show_on_dirs = true,
      timeout = 400,
    },
    actions = {
      use_system_clipboard = true,
      expand_all = {
        max_folder_discovery = 300,
        exclude = { "node_modules" },
      },
    },
    trash = {
      cmd = "gio trash",
      require_confirm = true,
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
  }

  nvtree.setup(config)
end

return {
  configure = configure
}
