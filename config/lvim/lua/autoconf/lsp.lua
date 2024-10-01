vim.lsp.set_log_level('debug')
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

require("lvim.lsp.manager").setup("marksman")

vim.list_extend(lvim.builtin.cmp.sources, { name = "cmp_nvim_r", priority_weight = 110 })
