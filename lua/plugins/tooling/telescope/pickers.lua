local M = {}

M.borderchars = {
  perimeter = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  divider   = { "─", "│", "─", "│", "├", "┤", "┘", "└" },

}

function M.default()
  return {}
end

function M.dropdown(opts)
  if not M._dropdown then
    M._dropdown = {
      theme = "dropdown",
      borderchars = {
        prompt = M.borderchars.perimeter,
        results = M.borderchars.divider,
        preview = M.borderchars.perimeter,
      },
    }
  end

  return opts and vim.tbl_deep_extend("keep", opts, M._dropdown) or M._dropdown
end

function M.cursor(opts)
  if not M._cursor then
    M._cursor = {
      theme = "cursor",
      borderchars = {
        prompt = M.borderchars.perimeter,
        results = M.borderchars.divider,
      },
    }
  end

  return opts and vim.tbl_deep_extend("keep", opts, M._cursor) or M._cursor
end

function M.ivy(opts)
  if not M._ivy then
    M._ivy = {
      theme = "ivy",
      borderchars = {
        preview = M.borderchars.perimeter,
      },
    }
  end

  return opts and vim.tbl_deep_extend("keep", opts, M._ivy) or M._ivy
end

return M
