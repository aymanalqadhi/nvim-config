local flutter = require("flutter-tools");

local function configure()
  flutter.setup {
    ui = {
      border = "rounded",
      notification_style = 'plugin' -- 'native' | 'plugin'
    },
    decorations = {
      statusline = {
        -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
        -- this will show the current version of the flutter app from the pubspec.yaml file
        app_version = true,
        -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
        -- this will show the currently running device if an application was started with a specific
        -- device
        device = true,
      }
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
      enabled = false,
      run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
      -- register_configurations = function(paths)
      --   require("dap").configurations.dart = {
      --   }
      -- end,
    },
    flutter_path = "/opt/flutter/bin/flutter", -- <-- this takes priority over the lookup
    flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
    fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
    widget_guides = {
      enabled = false,
    },
    closing_tags = {
      highlight = "Comment", -- highlight for the closing tag
      prefix = "//", -- character to use for close tag e.g. > Widget
      enabled = true -- set to false to disable
    },
    dev_log = {
      enabled = true,
      open_cmd = "tabedit", -- command to use to open the log buffer
    },
    dev_tools = {
      autostart = false, -- autostart devtools server if not detected
      auto_open_browser = false, -- Automatically opens devtools in the browser
    },
    outline = {
      open_cmd = "30vnew", -- command to use to open the outline buffer
      auto_open = false -- if true this will open the outline automatically when it is first populated
    },
    lsp = {
      color = { -- show the derived colours for dart variables
        enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
        background = true, -- highlight the background
        foreground = true, -- highlight the foreground
        virtual_text = true, -- show the highlight using virtual text
        virtual_text_str = "■", -- the virtual text character to highlight
      },
      settings = {
        showTodos = true,
        completeFunctionCalls = true,
        -- analysisExcludedFolders = {"<path-to-flutter-sdk-packages>"},
        renameFilesWithClasses = "prompt", -- "always"
        enableSnippets = true,
      }
    }
  }
end

return {
  configure = configure
}
