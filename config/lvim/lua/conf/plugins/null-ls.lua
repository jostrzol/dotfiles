--- Usage:
---
--- local null_ls = require("null-ls")
--- local null_ls_config = require("conf.plugins.null-ls");
---
--- table.insert(
---   null_ls_config.sources,
---   null_ls.builtins.diagnostics.cppcheck.with({
---     extra_args = { "--addon=c/misra.json" }
---   })
--- )

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

return {
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.mdformat,
    null_ls.builtins.formatting.cmake_format,
    null_ls.builtins.formatting.cppcheck,
    typstfmt,
  }
}
