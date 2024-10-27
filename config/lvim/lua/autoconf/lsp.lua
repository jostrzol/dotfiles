local lspmanager = require("lvim.lsp.manager")

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

-- manually config autocompletion sources
vim.list_extend(lvim.builtin.cmp.sources, { name = "cmp_nvim_r", priority_weight = 110 })
