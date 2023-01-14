local M = {}

function M.active_clients_names()
  local names = {}

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    table.insert(names, client.name)
  end

  return names
end

function M.active_clients_formatted_names()
  return table.concat(M.active_clients_names(), ', ')
end

function M.is_lsp_active()
  return next(vim.lsp.get_active_clients()) ~= nil
end

return M
