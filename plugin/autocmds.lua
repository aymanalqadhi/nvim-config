-- activate cursor line/column for active windows
void.event.on({ "InsertLeave", "WinEnter" }, function()
  vim.wo.cursorline = true
  vim.wo.cursorcolumn = true
end, { group = "global:cursorlc_gain" })

-- deactivate cursor line/column for inactive windows
void.event.on({ "InsertEnter", "WinLeave" }, function()
  vim.wo.cursorline = false
  vim.wo.cursorcolumn = false
end, { group = "global:cursorlc_lose" })

-- watch files for external changes
void.event.on({ "FocusGained", "TermClose", "TermLeave" }, "checktime", {
  group = "global:checktime"
})

-- highlight yanked text
void.event.on("TextYankPost", function()
  vim.highlight.on_yank({
    on_visual = false,
    timeout = 300,
    higroup = "Visual",
  })
end, { group = "global:yankhl" })
