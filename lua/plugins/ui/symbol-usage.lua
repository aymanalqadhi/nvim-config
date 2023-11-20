local SymbolKind = vim.lsp.protocol.SymbolKind

return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",

  keys = {
    {
      "glU",
      function()
        require("symbol-usage").refresh()
      end,
      "Refresh Symbol Usage",
    },
    {
      "glu",
      function()
        require("symbol-usage").toggle()
      end,
      "Toggle Symbol Usages",
    },
  },

  opts = {
    kinds = {
      SymbolKind.Function,
      SymbolKind.Method,
      SymbolKind.Enum,
      SymbolKind.Class,
      SymbolKind.Property,
      SymbolKind.Struct,
    },
    text_format = function(symbol)
      local fragments = {}

      if symbol.references then
        table.insert(fragments, symbol.references .. " refs")
      end

      if symbol.definition then
        table.insert(fragments, symbol.definition .. " defs")
      end

      if symbol.implementation then
        table.insert(fragments, symbol.implementation .. " impls")
      end

      -- local str = table.concat(fragments, ' • ')
      -- return '[' .. str .. ']'
      --
      local str = table.concat(fragments, " | ")
      return str
    end,
    definition = { enabled = true },
    implementation = { enabled = true },
  },
}
