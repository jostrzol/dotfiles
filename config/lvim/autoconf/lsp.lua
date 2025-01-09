local lspmanager = require("lvim.lsp.manager")
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

vim.lsp.set_log_level('debug')

-- remove automatic lsp servers
vim.list_extend(
  lvim.lsp.automatic_configuration.skipped_servers,
  { "rust_analyzer", "pyright", "harper_ls", "tinymist", "typst_lsp" }
)

-- add automatic lsp servers
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
  function(server)
    return server ~= "basedpyright"
  end,
  lvim.lsp.automatic_configuration.skipped_servers
)

-- manually config lsp servers
lspmanager.setup("marksman")
lspmanager.setup(
  "tinymist",
  {
    offset_encoding = "utf-8",
    settings = {
      formatterMode = "typstyle",
      exportPdf = "onSave",
    }
  }
)
-- should work but didn't test
lspmanager.setup("clangd", {
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})
-- if not, here's the old config
-- lspconfig.clangd.setup {
--   cmd = {
--     "clangd",
--     "--offset-encoding=utf-16",
--   },
-- }

-- register custom lsp servers
if not configs.fish_lsp then
  configs.fish_lsp = {
    default_config = {
      cmd = { "fish-lsp", "start" },
      root_dir = lspconfig.util.root_pattern('.git'),
      filetypes = { "fish" },
    },
  }
end

-- config custom lsp servers
lspconfig.fish_lsp.setup({})

-- manually config autocompletion sources
vim.list_extend(lvim.builtin.cmp.sources, { name = "cmp_nvim_r", priority_weight = 110 })
