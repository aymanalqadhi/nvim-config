return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  settings = {
    format = {
      enable = true,
    },
    schemaStore = {
      enable = true,
    },
    redhat = {
      telemetry = { enabled = false },
    },
  },
}
