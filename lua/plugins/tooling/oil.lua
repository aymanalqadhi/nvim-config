return {
  "stevearc/oil.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
  },

  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "oil: view dir" },
  },

  opts = {
    default_file_explorer = true,
    watch_for_changes = true,
    skip_confirm_for_simple_edits = true,

    columns = { "icon", "size", "mime" },
    view_options = { show_hidden = true },

    use_default_keymaps = false,
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },

      -- toggles
      ["gtt"] = { "actions.toggle_trash", mode = "n" },
      ["gt."] = { "actions.toggle_hidden", mode = "n" },
      ["gtc"] = function()
        local oil = require("oil")
        if not vim.b._oil_columns_hidden then
          oil.set_columns({})
        else
          require("oil").set_columns({ "icon", "size", "mtime" })
        end
        vim.b._oil_columns_hidden = not vim.b._oil_columns_hidden
      end,

      -- actions
      ["<m-q>"] = "actions.close",
      ["<m-p>"] = "actions.preview",
      ["<m-r>"] = "actions.refresh",
      ["<m-s>"] = { "actions.select", opts = { horizontal = true } },
      ["<m-v>"] = { "actions.select", opts = { vertical = true } },
      ["<m-h>"] = "actions.select_split",
      ["<m-t>"] = { "actions.open_terminal", mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },

      -- navigation
      ["<cr>"] = { "actions.select", mode = "n" },
      [">"] = { "actions.select", mode = "n" },
      ["<"] = { "actions.parent", mode = "n" },

      ["<leader>of"] = {
        function()
          require("telescope.builtin").find_files({
            cwd = require("oil").get_current_dir(),
          })
        end,
        mode = "n",
        nowait = true,
        desc = "oil: find files in the current directory",
      },
    },
  },

  config = function(_, opts)
    require("oil").setup(opts)

    -- confirm quit for empty buffers
    void.event.on("BufUnload", function(args)
      if vim.api.nvim_buf_get_name(args.buf) == "" then
        vim.cmd("confirm q")
      end
    end, { pattern = "oil://*" })

    -- close buffers associated with deleted files
    void.event.on("User", function(args)
      if args.data.err then
        return
      end

      for _, action in ipairs(args.data.actions) do
        if action.type == "delete" then
          local bufnr = vim.fn.bufnr(vim.uri_to_fname(action.url))
          if bufnr ~= -1 then
            vim.api.nvim_buf_delete(bufnr, { force = false })
          end
        end
      end
    end, { pattern = "OilActionsPost" })
  end,

  init = function()
    ---@diagnostic disable-next-line: param-type-mismatch
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      require("lazy").load({ plugins = { "oil.nvim" } })
    end
  end,
}
