local Path = require "plenary.path"

---@type LazyPluginSpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    -- adapters
    -- "nvim-neotest/neotest-python",
    -- "nvim-neotest/neotest-plenary",
    -- "nvim-neotest/neotest-vim-test",
    -- "vim-test/vim-test",
  },
  opts = {
    adapters = {
      require "neotest-python" {
        dap = {
          justMyCode = false,
          console = "integratedTerminal",
        },
        -- args = {},
        runner = "unittest",
        python = { "venv/bin/python3" },
        is_test_file = function(file_path)
          if not vim.endswith(file_path, ".py") then return false end
          local elems = vim.split(file_path, Path.path.sep)
          local file_name = elems[#elems]
          return vim.startswith(file_name, "test") or vim.endswith(file_name, "test.py")
        end,
        -- python = { "venv/bin/python" },
      },
      -- require "neotest-python" {
      --   dap = {
      --     justMyCode = false,
      --     console = "integratedTerminal",
      --   },
      --   args = { "--log-level", "DEBUG", "--quiet" },
      --   runner = "pytest",
      --   python = { ".venv/bin/python", "/usr/bin/python3" },
      -- },
      -- require "neotest-plenary",
      -- require "neotest-vim-test" {
      --   ignore_file_types = { "python", "vim", "lua" },
      -- },
    },
  },
}
