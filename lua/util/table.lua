local M = {}

function M.safe_extend(lhs, rhs)
  assert(type(lhs) == type(rhs) and type(lhs), "both arguments must be tables")

  for k, v in pairs(rhs) do
    if not lhs[k] then
      lhs[k] = v
    elseif type(k) == "number" then
      table.insert(lhs, v)
    elseif type(v) == "table" then
      M.safe_extend(lhs[k], v)
    else
      error(string.format("duplicate primitive key `%s` %s", type(k), type(k)), 2)
    end
  end
end

return M
