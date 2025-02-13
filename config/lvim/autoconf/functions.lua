function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

---@class LazygitToggleParams
---@field args string[] Arguments passed to lazygit command

-- Based on lvim.core.terminal.lazygit_toggle
---@param params LazygitToggleParams
_G.lazygit_toggle = function(params)
  params = params or {}
  local cmd_parts = {"lazygit", unpack(params.args or {})}
  local cmd = table.concat(cmd_parts, " ")

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new {
    cmd = cmd,
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
      zindex = 200,
    },
    on_open = function(_)
      vim.cmd "startinsert!"
    end,
    on_close = function(_) end,
    count = 99,
  }
  lazygit:toggle()
end
