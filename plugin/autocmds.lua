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
  vim.hl.on_yank({
    on_visual = false,
    timeout = 300,
    higroup = "Visual",
  })
end, { group = "global:yankhl" })

-- close some filetypes with <q>
void.event.on("FileType", function(args)
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

-- create parent directories of a file (if they do not exist) before writing
void.event.on("BufWritePre", function(args)
  if not args.match:match("^%w%w+:[\\/][\\/]") then
    local filename = vim.uv.fs_realpath(args.match) or args.match
    local dirname = vim.fs.dirname(filename)

    if dirname and not vim.uv.fs_stat(dirname) then
      local cwd = vim.uv.cwd()
      local stat = cwd and vim.uv.fs_stat(cwd)
      local mode = stat and string.format("0o%o", stat.mode)

      vim.fn.mkdir(vim.fs.abspath(dirname), "p", mode)
    end
  end
end, { group = "global:auto_create_dir" })
