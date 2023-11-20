return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  ft = { "qf" },
  keys = {
    { "<leader>tt", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>tT", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>tl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>", desc = "Quickfix List (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if err and not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },

  config = function(_, opts)
    require("trouble").setup(opts)

    -- replace default quickfix window with trouble
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = { "quickfix", "loclist" },
      callback = function()
        local ok, trouble = pcall(require, "trouble")
        if ok then
          vim.defer_fn(function()
            vim.cmd("cclose")
            trouble.open("quickfix")
          end, 0)
        end
      end,
    })
  end,
}
