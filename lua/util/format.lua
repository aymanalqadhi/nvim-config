local M = setmetatable({}, {
  __call = function(m, ...)
    return m.format(...)
  end,
})

function M.register(formatter)
  if formatter.enabled ~= false then
    formatter.enabled = true
  end

  if not M.formatters then
    M.formatters = { formatter }
  else
    M.formatters[#M.formatters + 1] = formatter

    table.sort(M.formatters, function(a, b)
      return a.priority > b.priority
    end)
  end
end

function M.iter_formatters(cb)
  for _, formatter in ipairs(M.formatters) do
    if formatter.enabled and cb(formatter) then
      return true
    end
  end

  return false
end

function M.formatexpr()
  if #M.formatters > 0 then
    return M.formatters[1].formatexpr()
  end
end

function M.format(opts)
  local buffer = vim.api.nvim_get_current_buf()

  opts = vim.tbl_extend("keep", opts, {
    buffer = buffer,
    bufnr = buffer,
  })

  return M.iter_formatters(function(f)
    return f.format(opts)
  end)
end

return M
