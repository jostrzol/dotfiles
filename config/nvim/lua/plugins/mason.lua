-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",
        "sqlfluff",
        "markdownlint",
        "prettierd",
        -- "prettier",
        "black",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function()
      local null_ls = require "null-ls"
      return {
        sources = {
          -- Diagnostics/linters
          -- null_ls.builtins.diagnostics.markdownlint.with {
          --   extra_filetypes = { "quarto" },
          --   extra_args = { "--disable", "MD013" },
          -- },
          -- Formatters
          -- null_ls.builtins.formatting.prettier.with {
          --   filetypes = { "markdown" },
          -- },
        },
        -- debug = true, -- switch
      }
    end,
  },
}
