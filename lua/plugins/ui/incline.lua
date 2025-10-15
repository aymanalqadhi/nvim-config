return {
  "b0o/incline.nvim",

  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "BufAdd",

  config = function()
    local di = require("nvim-web-devicons")
    local helpers = require("incline.helpers")

    require("incline").setup({
      hide = {
        cursorline = true,
        focused_win = false,
        only_win = false,
      },
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local fname = vim.api.nvim_buf_get_name(props.buf)
        if fname == "" then
          return nil
        end

        local ret = {
          {
            " ", vim.fs.basename(fname), " ",
            gui = "bold",
          },
        }

        -- add icon
        local icon, iconhl = di.get_icon_color(fname)
        if icon then
          local block = { " ", icon, " " }
          if props.focused then
            block.guibg = iconhl
            block.guifg = helpers.contrast_color(iconhl)
          else
            block.guifg = iconhl
          end

          table.insert(ret, 1, block)
        end

        return ret
      end,
    })
  end,
}
