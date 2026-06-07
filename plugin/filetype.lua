vim.filetype.add({
  extension = {
    -- h = "c",
  },
  filename = {
    ["buf.yaml"] = "buf-config",
    ["buf.gen.yaml"] = "buf-config",
    ["buf.policy.yaml"] = "buf-config",
    ["buf.lock"] = "buf-config",
  },
})

vim.treesitter.language.register("yaml", { "buf-config" })
