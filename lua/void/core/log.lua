---Logging utilities.
---@class void.log
local M = {}

-- log levels
M.DEBUG = 1
M.INFO = 2
M.WARN = 3
M.ERROR = 4
M.FATAL = 5
M.LEVELS = {
  { "DEBUG: ", "MoreMsg"  },
  { "INFO: " , "InfoMsg"  },
  { "WARN: " , "WarnMsg"  },
  { "ERROR: ", "ErrorMsg" },
  { "FATAL: ", "ErrorMsg" },
}

---Logs the given format and parameters.
---@param lvl number The level to log the message with.
---@param fmt string The message format to log.
---@param ... any    Parameters to generate the log message from `fmt`.
function M.log(lvl, fmt, ...)
  local level = M.LEVELS[lvl] or M.fatal("invalid log level: %d", lvl)

  vim.api.nvim_echo({
    { string.format(level[1] .. fmt, ...), level[2] },
  }, true, {})
end

---Logs the given message in DEBUG level.
---@param fmt string The message format to log.
---@param ... any    Parameters to generate the log message from `fmt`.
function M.debug(fmt, ...)
  M.log(M.DEBUG, fmt, ...)
end

---Logs the given message in INFO level.
---@param fmt string The message format to log.
---@param ... any    Parameters to generate the log message from `fmt`.
function M.info(fmt, ...)
  M.log(M.INFO, fmt, ...)
end

---Logs the given message in WARN level.
---@param fmt string The message format to log.
---@param ... any    Parameters to generate the log message from `fmt`.
function M.warn(fmt, ...)
  M.log(M.WARN, fmt, ...)
end

---Logs the given message in ERROR level.
---@param fmt string The message format to log.
---@param ... any    Parameters to generate the log message from `fmt`.
function M.error(fmt, ...)
  M.log(M.ERROR, fmt, ...)
end

---Prints the given message in FATAL level, then quits.
---@param fmt string The message format to log.
---@param ... any    Parameters to generate the log message from `fmt`.
function M.fatal(fmt, ...)
  M.log(M.FATAL, fmt, ...)

  vim.fn.getchar()
  vim.cmd([[quit]])
end

return M
