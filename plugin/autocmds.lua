local function augroup(name)
  return vim.api.nvim_create_augroup("void_" .. name, { clear = true })
end

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorlc")
    if ok and cl then
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = true
      vim.api.nvim_win_del_var(0, "auto-cursorlc")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorlc", cl)
      vim.wo.cursorline = false
      vim.wo.cursorcolumn = false
    end
  end,
})

-- reload file on change
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ on_visual = false, higroup = "Visual" })
  end,
})



})

