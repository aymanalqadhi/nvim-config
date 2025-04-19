return {
  "kndndrj/nvim-dbee",

  dependencies = { "MunifTanjim/nui.nvim" },

  keys = {
    { "<localleader>do", function() require("dbee").open() end,   desc = "db: open explorer" },
    { "<localleader>dc", function() require("dbee").close() end,  desc = "db: close explorer" },
    { "<localleader>dd", function() require("dbee").toggle() end, desc = "db: toggle explorer" },
  },

  build = function()
    require("dbee").install()
  end,

  config = function(_, opts)
    require("dbee").setup(opts)
  end
}
