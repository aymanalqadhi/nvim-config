return {
  "zbirenbaum/copilot.lua",

  cmd = "Copilot",
  event = "InsertEnter",

  opts = {
    panel = { enabled = false, },
    suggestion = {
      enabled = true,
      debounce = 100,
    },
    filetypes = {
      sh = function()
        local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        return not string.match(filename, "^%.env.*")
      end,
    },
  },
}
