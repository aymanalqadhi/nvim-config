return {
  -- better syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",

    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    priority = 900,

    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment selection", mode = { "n", "v" } },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },

    opts = function()
      local swap_next, swap_prev = (function()
        local swap_objects = {
          p = "@parameter.inner",
          f = "@function.outer",
          e = "@element",

          -- Not ready, but I think it's my fault :)
          -- v = "@variable",
        }

        local n, p = {}, {}
        for key, obj in pairs(swap_objects) do
          n[string.format("<M-Space><M-%s>", key)] = obj
          p[string.format("<M-BS><M-%s>", key)] = obj
        end

        return n, p
      end)()

      return {
        -- better syntax highlighting
        highlight = {
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = false,
        },

        -- better indentation
        indent = { enable = true },

        -- context-aware selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            scope_incremental = "<c-cr>",
            node_decremental = "<bs>",
          },
          -- keymaps = {
          --   init_selection = "<C-space>",
          --   node_incremental = "<C-space>",
          --   scope_incremental = "<C-S-Space>",
          --   node_decremental = "<bs>",
          -- },
        },

        -- more text objects
        textobjects = {
          move = {
            enable = true,
            goto_next_start = {
              ["]p"] = "@parameter.inner",
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[p"] = "@parameter.inner",
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },

        -- selection plugin
        select = {
          enable = true,
          lookahead = true,

          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",

            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",

            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",

            ["av"] = "@variable.outer",
            ["iv"] = "@variable.inner",
          },
        },

        -- refactor plugin
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = false },

          smart_rename = {
            enable = false,
            keymaps = {
              -- mapping to rename reference under cursor
              smart_rename = "grr",
            },
          },

          navigation = {
            enable = false,
            keymaps = {
              goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
              list_definitions = "gnD", -- mapping to list all definitions in current file
            },
          },
        },

        -- swapping
        swap = {
          enable = true,
          swap_next = swap_next,
          swap_previous = swap_prev,
        },

        -- pre-installed parsers
        ensure_installed = {
          "diff",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "query",
          "regex",
          "vim",
          "vimdoc",
        },
      }
    end,

    config = function(_, opts)
      -- load parsers only once.
      if type(opts.ensure_installed) == "table" then
        local added = {}

        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end

          added[lang] = true

          return true
        end, opts.ensure_installed)
      end

      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  init = function()
    local list = require("nvim-treesitter.parsers").get_parser_configs()

    list.sql = {
      install_info = {
        url = "https://github.com/DerekStride/tree-sitter-sql",
        branch = "main",
        files = { "src/parser.c" },
      },
      filetype = "sql",
    }

    list.lua = {
      install_info = {
        url = "https://github.com/tjdevries/tree-sitter-lua",
        revision = "0e860f697901c9b610104eb61d3812755d5211fc",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
    }
  end,

  -- Show context of the current function
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = true,
    opts = {
      mode = "cursor",
    },
  },
}
