local null_ls = require("null-ls")

local typstfmt = {
  method = null_ls.methods.FORMATTING,
  filetypes = { "typst" },
  generator = null_ls.formatter({
    command = "typstfmt",
    args = { "--stdout" },
    to_stdin = true,
    from_stderr = true,
  }),
}

---@diagnostic disable-next-line: redundant-parameter (it lies)
null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.mdformat,
    null_ls.builtins.formatting.cmake_format,
    typstfmt,
  }
})
