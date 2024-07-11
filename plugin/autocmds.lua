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
void.event.on({ "FocusGained", "TermClose", "TermLeave" }, function()
  if vim.o.buftype ~= "nofile" then
    vim.cmd("checktime")
  end
end, { group = "global:checktime" })

-- highlight yanked text
void.event.on("TextYankPost", function()
  vim.highlight.on_yank({
    on_visual = false,
    timeout = 300,
    higroup = "Visual",
  })
end, { group = "global:yankhl" })

-- close some filetypes with <q>
void.event.on("FileType",
  function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>bdelete<cr>", { buffer = args.buf })
  end, {
    group = "global:quickq",
    pattern = {
      "man",
      "help",
      "lspinfo",
      "notify",
      "qf",
      "startuptime",
      "checkhealth",
      "dbout",
      "gitsigns.blame",
    },
  })
