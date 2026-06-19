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
        "sqlfluff",
        "markdownlint",
        "prettierd",
        "black",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(
        function(server) return server ~= "basedpyright" and server ~= "pyrefly" end,
        opts.ensure_installed or {}
      )
    end,
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
