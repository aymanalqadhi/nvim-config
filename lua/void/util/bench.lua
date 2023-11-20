---Benchmarking utilities.
---@class void.util.bench
local M = {}

---Measures the time it takes to run a function in seconds.
---@param  fn function # Function to measure
---@return    number   # The number of seconds it took to run the function.
function M.measure(fn)
  assert(vim.is_callable(fn), "Expected a function")

  local start = os.clock()
  fn()
  return os.clock() - start
end

return M
