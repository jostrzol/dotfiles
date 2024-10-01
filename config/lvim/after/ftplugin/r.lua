vim.o.textwidth = 80

-- Keymaps
vim.keymap.set(
  { "n", "o" }, "<LocalLeader>rf",
  function()
    local r_terminal_window = R_get_terminal_buffer_window()
    if r_terminal_window == nil or r_terminal_window == -1 then
      vim.api.nvim_call_function("StartR", { "R" })
    else
      local height = vim.api.nvim_win_get_height(r_terminal_window)
      if height == 1 then
        vim.api.nvim_win_set_height(r_terminal_window, 20)
      else
        vim.api.nvim_win_set_height(r_terminal_window, 1)
      end
    end
  end,
  { silent = false, noremap = true, desc = "Toggle R terminal" }
)
