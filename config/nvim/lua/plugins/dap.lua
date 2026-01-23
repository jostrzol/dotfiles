-- local dap = require "dap"

---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand "$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
            "127.0.0.1",
          },
        },
      }
      require("dap").adapters["pwa-chrome"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand "$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
            "127.0.0.1",
          },
        },
      }

      -- require('dap').set_log_level('TRACE')
    end,
  },
  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        default_section = "repl",
      },
      auto_toggle = true,
    },
  },
}
