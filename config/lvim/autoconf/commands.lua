vim.api.nvim_create_user_command(
  "Map",
  function()
    local map = vim.api.nvim_exec2("silent verbose map", { output = true })
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_buf_set_name(buf, "Keyboard map")
    local lines = {}
    for s in map.output:gmatch("[^\r\n]+") do
      table.insert(lines, s)
    end

    vim.api.nvim_put(lines, "", false, false)
  end,
  {}
)

vim.api.nvim_create_user_command(
  "DapClearBreakpoints",
  function()
    require("dap").clear_breakpoints()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "DapBreakpointConditional",
  function(cmd)
    require("dap").toggle_breakpoint(cmd.args)
  end,
  { nargs = '?' }
)

vim.api.nvim_create_user_command(
  "LspCapabilities",
  function(_)
    local buffer = vim.api.nvim_get_current_buf()
    ---@type (lsp.ServerCapabilities?)
    local capabilities = {}
    for _, client in pairs(vim.lsp.get_clients({ bufnr = buffer })) do
      capabilities = vim.tbl_deep_extend("force", capabilities, client.server_capabilities)
    end
    put(capabilities)
  end,
  {}
)
