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
        -- args = { "--log-level", "DEBUG", "--quiet" },
        runner = "pytest",
        python = { ".venv/bin/python", "venv/bin/python", "/usr/bin/python3" },
      },
      -- require "neotest-plenary",
      -- require "neotest-vim-test" {
      --   ignore_file_types = { "python", "vim", "lua" },
      -- },
    },
  },
}
