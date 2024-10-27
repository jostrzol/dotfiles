vim.o.textwidth = 80

-- Keymaps
vim.keymap.set(
  { "n", "o" }, "<LocalLeader>rf",
  R_toggle_terminal,
  { silent = false, noremap = true, desc = "Toggle R terminal" }
)
vim.keymap.set(
  { "i", "n", "o" }, "<M-r>",
  R_toggle_terminal,
  { silent = false, noremap = true, desc = "Toggle R terminal" }
)

-- Auto commands
vim.api.nvim_create_autocmd(
  { "WinEnter" },
  {
    callback = function()
      local r_terminal = R_get_terminal_buffer_window()
      if r_terminal ~= nil and r_terminal ~= -1 then
        vim.api.nvim_win_set_option(r_terminal, "number", false)
      end

      local current_win = vim.api.nvim_get_current_win()
      if current_win == r_terminal then
        vim.schedule(function() vim.cmd("startinsert") end)
      end
    end
  }
)
