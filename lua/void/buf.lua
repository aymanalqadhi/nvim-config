-- source: https://github.com/folke/snacks.nvim/blob/main/lua/snacks/bufdelete.lua

---@class Void.buf
local M = {}

---@class Void.buf.delete_opts
---@field buf? (integer) Buffer to delete. Defaults to the current buffer
---@field force? (boolean) Delete the buffer event if modified
---@field wipe? (boolean) Wipe the buffer instead of deleting it
---@field filter? fun(buf: integer): boolean Filter buffers to delete

--- Delete a buffer
---@param opts? (integer|Void.buf.delete_opts) Options
function M.delete(opts)
  if type(opts) == "table" then
    if type(opts.filter) == "function" then
      opts.filter = nil
      for _, b in ipairs(vim.tbl_filter(opts.filter, vim.api.nvim_list_bufs())) do
        if vim.bo[b].buflisted then
          opts.buf = b
          M.delete(opts)
        end
      end
      return
    end
  else
    opts = { buf = type(opts) == "number" and opts or 0 }
  end

  local buf = opts.buf ~= 0 and opts.buf or vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_call(buf, function()
    if vim.bo.modified and not opts.force then
      local ok, choice = pcall(
        vim.fn.confirm,
        ("Save changes to %q?"):format(vim.fn.bufname()),
        "&Yes\n&No\n&Cancel"
      )
      if not ok or choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
        return
      end
      if choice == 1 then -- Yes
        vim.cmd.write()
      end
    end

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      vim.api.nvim_win_call(win, function()
        if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
          return
        end

        -- Try using alternate buffer
        local alt = vim.fn.bufnr("#")
        if alt ~= buf and vim.fn.buflisted(alt) == 1 then
          vim.api.nvim_win_set_buf(win, alt)
          return
        end

        -- Try using previous buffer
        local has_prev = pcall(vim.api.nvim_cmd, { cmd = "bprevious" }, {})
        if has_prev and buf ~= vim.api.nvim_win_get_buf(win) then
          return
        end

        -- Create new listed buffer
        local new_buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_win_set_buf(win, new_buf)
      end)
    end

    if vim.api.nvim_buf_is_valid(buf) then
      pcall(vim.api.nvim_cmd, {
        cmd = opts.wipe and "bwipeout" or "bdelete",
        args = { tostring(buf) },
        bang = true,
      }, {})
    end
  end)
end

--- Delete all buffers
---@param opts? (Void.buf.delete_opts) Options
function M.all(opts)
  return M.delete(vim.tbl_extend("force", {}, opts or {}, {
    filter = function()
      return true
    end,
  }))
end

--- Delete all buffers except the current one
---@param opts? (Void.buf.delete_opts) Options
function M.other(opts)
  return M.delete(vim.tbl_extend("force", {}, opts or {}, {
    filter = function(b)
      return b ~= vim.api.nvim_get_current_buf()
    end,
  }))
end

return M
