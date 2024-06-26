local null_ls = require("null-ls")

---@diagnostic disable-next-line: redundant-parameter (it lies)
null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.mdformat,
  }
})
