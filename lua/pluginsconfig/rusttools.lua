local rt = require('rust-tools')
local rt_dap = require('rust-tools.dap')

local function configure()
  local mason_reg = require('mason-registry')
  local ext_path = mason_reg.get_package('codelldb'):get_install_path()

  local codelldb_path = ext_path .. '/extension/adapter/codelldb'
  local liblldb_path = ext_path .. '/extension/lldb/lib/liblldb.so'

  rt.setup {
    dap = {
      adapter = rt_dap.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    server = {
      on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Hover actions
        vim.keymap.set("n", ";h", rt.hover_actions.hover_actions, opts)
        -- Code action groups
        vim.keymap.set("n", ";H", rt.code_action_group.code_action_group, opts)
        -- Open Cargo.toml
        vim.keymap.set("n", ";c", rt.code_action_group.code_action_group, opts)
        -- Expand macro
        vim.keymap.set("n", ";m", rt.expand_macro.expand_macro, opts)
        -- Parent module
        vim.keymap.set("n", ";M", rt.parent_module.parent_module, opts)
      end,
    },
  }

end

return {
  configure = configure
}
