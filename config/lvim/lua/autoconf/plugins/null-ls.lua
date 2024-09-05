local null_ls = require("null-ls")
local config = require("conf.plugins.null-ls")

vim.api.nvim_create_autocmd("User", {
  pattern = "ConfigLocalFinished",
  callback = function() null_ls.setup(config) end,
})
