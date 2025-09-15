-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      automatic_installation = false,
      ensure_installed = { "stylua", "sqlfluff", "markdownlint", "prettierd", "prettier" },
      handlers = {
        sqlfluff = function()
          local null_ls = require "null-ls"

          null_ls.register(null_ls.builtins.diagnostics.sqlfluff)
          null_ls.register(null_ls.builtins.formatting.sqlfluff)
        end,
        markdownlint = function()
          local null_ls = require "null-ls"

          null_ls.register(null_ls.builtins.diagnostics.markdownlint.with {
            extra_filetypes = { "quarto" },
            extra_args = { "--disable", "MD013" },
          })
        end,
        prettierd = function()
          local null_ls = require "null-ls"

          null_ls.register(null_ls.builtins.formatting.prettier.with {
            filetypes = { "markdown" },
          })
        end,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        -- add more arguments for adding more debuggers
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = {
      -- debug = true, -- switch
    },
  },
}
