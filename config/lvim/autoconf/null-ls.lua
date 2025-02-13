local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

lvim.lsp.null_ls.setup.debug = true

-- FORMATTERS
require("lvim.lsp.null-ls.formatters").setup {
  { name = "markdownlint" },
  { name = "mdformat" },
  { name = "cmake_format" },
}

null_ls.register({
  helpers.make_builtin(
    {
      name = "typstyle",
      method = null_ls.methods.FORMATTING,
      filetypes = { "typst" },
      generator = null_ls.formatter({
        command = "typstyle",
        args = { "--inplace", "$FILENAME" },
        to_temp_file = true,
        from_temp_file = true,
        -- to_stdin = true,
        -- from_stderr = true,
      }),
    }
  )
})

-- LINTERS
require("lvim.lsp.null-ls.linters").setup {
  {
    name = "markdownlint",
    extra_filetypes = { "rmd" },
    extra_args = { "--disable MD025 MD024" }
  },
}

-- CODE ACTIONS
-- require("lvim.lsp.null-ls.code_actions").setup {
--
-- }
