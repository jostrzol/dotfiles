vim.lsp.set_log_level('debug')
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
