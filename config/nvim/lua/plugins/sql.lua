---@type LazyPluginSpec
return {
  "jay-babu/mason-null-ls.nvim",
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "sqlfluff" })
    opts.handlers = {
      sqlfluff = function()
        local null_ls = require "null-ls"
        null_ls.register(null_ls.builtins.diagnostics.sqlfluff)
        null_ls.register(null_ls.builtins.formatting.sqlfluff)
      end,
    }
  end,
}
