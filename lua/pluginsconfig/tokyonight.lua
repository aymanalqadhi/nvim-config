local tokyonight = require('tokyonight')

local function configure()
  tokyonight.setup {
    style = "storm",
    transparent = true,
    terminal_colors = true,

    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },

    sidebars = { "qf", "help" },
    day_brightness = 0.3,
    hide_inactive_statusline = true,
    dim_inactive = true,
    lualine_bold = false,

    -- on_highlights = function(hl, c)
    --   local prompt = "#2d3149"
    --   hl.TelescopeNormal = {
    --     bg = c.bg_dark,
    --     fg = c.fg_dark,
    --   }
    --   hl.TelescopeBorder = {
    --     bg = c.bg_dark,
    --     fg = c.bg_dark,
    --   }
    --   hl.TelescopePromptNormal = {
    --     bg = prompt,
    --   }
    --   hl.TelescopePromptBorder = {
    --     bg = prompt,
    --     fg = prompt,
    --   }
    --   hl.TelescopePromptTitle = {
    --     bg = prompt,
    --     fg = prompt,
    --   }
    --   hl.TelescopePreviewTitle = {
    --     bg = c.bg_dark,
    --     fg = c.bg_dark,
    --   }
    --   hl.TelescopeResultsTitle = {
    --     bg = c.bg_dark,
    --     fg = c.bg_dark,
    --   }
    -- end,
  }

  -- colorscheme
  vim.cmd("colorscheme tokyonight")
end

return {
  configure = configure
}
