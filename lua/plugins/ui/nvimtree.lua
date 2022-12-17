local M = {}

-- plugin uri
M.uri = 'DaikyXendo/nvim-tree.lua'

-- plugin requirements
M.requirements = { 'DaikyXendo/nvim-material-icon' }

-- plugin configuration function
function M.configure()
  require('nvim-tree').setup {
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = true,
    open_on_setup_file = false,
    sort_by = "name",
    root_dirs = {},

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
    },

    git = {
      enable = true,
      ignore = true,
    },

    actions = {
      use_system_clipboard = true,
      expand_all = {
        max_folder_discovery = 300,
        exclude = { "node_modules" },
      },
    },

    live_filter = {
      prefix = "   ",
    },
  }

  -- configure material icons
  local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")

  if not web_devicons_ok then
    return
  end

  local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")

  if not material_icon_ok then
    return
  end

  web_devicons.setup({
    override = material_icon.get_icons(),
  })

end

-- plugin keymaps
function M.keymaps()
  return {
    ['<A-t>'] = { '<cmd>NvimTreeToggle<cr>', 'Toggle Tree' },
  }
end

return M
