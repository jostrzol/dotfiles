-- Example local configuration that:
-- * sets the python test runner to unittest
-- * discovers tests in format test*.py
-- * disables ruff, black and isort formatters
-- * sets up a custom autopep8 formatter

if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local Path = require "plenary.path"

---@type LazyPluginSpec[]
return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        require "neotest-python" {
          runner = "unittest",
          python = { "venv/bin/python3" },
          is_test_file = function(file_path)
            if not vim.endswith(file_path, ".py") then return false end
            local elems = vim.split(file_path, Path.path.sep)
            local file_name = elems[#elems]
            return vim.startswith(file_name, "test") or vim.endswith(file_name, "test.py")
          end,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      formatting = {
        disabled = { "ruff" },
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "autopep8" },
      handlers = {
        black = function() end,
        isort = function() end,
        autopep8 = function()
          local null_ls = require "null-ls"
          local helpers = require "null-ls.helpers"

          local autopep8 = {
            name = "autopep8",
            method = { null_ls.methods.FORMATTING, null_ls.methods.RANGE_FORMATTING },
            filetypes = { "python" },
            generator = null_ls.formatter {
              command = "autopep8",
              args = helpers.range_formatting_args_factory({ "-" }, "--line-range", nil, { use_rows = true }),
              to_stdin = true,
            },
          }
          null_ls.register(autopep8)
        end,
      },
    },
  },
}
