-- local dap = require "dap"

---@type LazySpec
return {
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
