local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

if not configs.fish_lsp then
  configs.fish_lsp = {
    default_config = {
      cmd = { "fish-lsp", "start" },
      root_dir = lspconfig.util.root_pattern('.git'),
      filetypes = { "fish" },
    },
  }
end

lspconfig.fish_lsp.setup({})

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
