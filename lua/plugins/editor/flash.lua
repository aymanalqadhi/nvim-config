return {
  "folke/flash.nvim",

  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "flash: jump" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash: treesitter jump" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "flash: toggle" },
  },
}
