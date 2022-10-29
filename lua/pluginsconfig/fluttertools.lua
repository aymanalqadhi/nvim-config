local flutter = require("flutter-tools");

local function configure()
  flutter.setup {
    ui = {
      border = "rounded", -- "single" | "shadow" | {<table-of-eight-chars>}
      notification_style = 'plugin'
    },
    decorations = {
      statusline = {
        app_version = true,
        device = true,
      }
    },
    debugger = {
      enabled = true,
      run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
      exception_breakpoints = {},
      register_configurations = function(_)
        require("dap").configurations.dart = {}
        require("dap.ext.vscode").load_launchjs()
      end,
    },
    --flutter_path = "<full/path/if/needed>",
    --flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
    widget_guides = {
      enabled = true,
    },
    closing_tags = {
      highlight = "Comment", -- highlight for the closing tag
      prefix = "<//",
      enabled = true,
    },
    dev_log = {
      enabled = true,
      open_cmd = "tabedit",
    },
    dev_tools = {
      autostart = false,
      auto_open_browser = false, -- Automatically opens devtools in the browser
    },
    outline = {
      open_cmd = "30vnew",
      auto_open = false,
    },
    lsp = {
      color = {
        enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
        background = true, -- highlight the background
        foreground = false, -- highlight the foreground
        virtual_text = true, -- show the highlight using virtual text
        virtual_text_str = "■", -- the virtual text character to highlight
      },
      --capabilities = function(config)
      --  --config.specificThingIDontWant = false
      --  return config
      --end,
      -- see the link below for details on each option:
      -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
      settings = {
        showTodos = true,
        completeFunctionCalls = true,
        analysisExcludedFolders = { "/opt/flutter/" },
        renameFilesWithClasses = "prompt",
        enableSnippets = true,
      }
    }
  }
end

return {
  configure = configure
}
