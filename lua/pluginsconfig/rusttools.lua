local rust_tools = require('rust-tools');

local function configure()
  local ext_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/'
  local codelldb_path = ext_path .. 'adapter/codelldb'
  local liblldb_path = ext_path .. 'lldb/lib/liblldb.so'

  rust_tools.setup {
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter {
        codelldb_path,
        liblldb_path,
      },
    },
  }
end

return {
  configure = configure
}
