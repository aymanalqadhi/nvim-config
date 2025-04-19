return {
  "luukvbaal/statuscol.nvim",

  config = function()
    local builtin = require("statuscol.builtin")

    require("statuscol").setup({
      setopt = true,
      relculright = true,
      ft_ignore = { "NvimTree" },
      segments = {
        {
          sign = {
            name = { ".*" },
            namespace = { ".*" },
            -- maxwidth = 2,
            -- colwidth = 2,
            auto = false,
            wrap = true,
          },
          click = "v:lua.ScSa",
        },
        {
          text = { builtin.lnumfunc, " " },
          colwidth = 1,
          click = "v:lua.ScLa",
        },
        {
          sign = {
            name = { "GitSigns*" },
            namespace = { "gitsigns" },
            colwidth = 1,
            fillcharhl = "Nrline",
          },
          click = "v:lua.ScSa",
        },
        {
          text = { builtin.foldfunc, " " },
          hl = "FoldColumn",
          wrap = true,
          colwidth = 1,
          click = "v:lua.ScFa",
        },
      },
    })
  end,
}
