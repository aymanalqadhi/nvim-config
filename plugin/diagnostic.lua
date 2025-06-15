-- diagnostics config
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = function(diagnostic)
      local icons = void.config.icons.diagnostics
      for d, icon in pairs(icons.signs) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
          return icon
        end
      end
      return icons.prefix
    end,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = void.config.icons.diagnostics.signs.Error,
      [vim.diagnostic.severity.WARN] = void.config.icons.diagnostics.signs.Warning,
      [vim.diagnostic.severity.INFO] = void.config.icons.diagnostics.signs.Info,
      [vim.diagnostic.severity.HINT] = void.config.icons.diagnostics.signs.Hint,
    },
  },
})
