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

-- Lua functions
local _term_protocol = "term://"
local _r_term_suffix = ":R"

function R_get_terminal_buffer_window()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in pairs(buffers) do
    local name = vim.api.nvim_buf_get_name(buffer)

    local len = string.len(name)
    local protocol = string.sub(name, 1, string.len(_term_protocol))
    local suffix = string.sub(name, len - string.len(_r_term_suffix), len - 1)
    if protocol == _term_protocol and suffix == _r_term_suffix then
      return vim.fn.bufwinid(buffer)
    end
  end
  return nil
end

function R_toggle_terminal()
  local r_terminal_window = R_get_terminal_buffer_window()
  if r_terminal_window == nil or r_terminal_window == -1 then
    vim.api.nvim_create_autocmd({ "WinEnter" },
      {
        callback = function()
          r_terminal_window = R_get_terminal_buffer_window()
          if (r_terminal_window == nil or r_terminal_window == -1) then
            return false
          end

          local current_window = vim.api.nvim_get_current_win()
          vim.api.nvim_set_var("r_last_window", current_window)
          vim.api.nvim_set_current_win(r_terminal_window)
          return true   -- delete auto command
        end,
      }
    )
    vim.api.nvim_call_function("StartR", { "R" })
  else
    local height = vim.api.nvim_win_get_height(r_terminal_window)
    if height == 1 then
      vim.api.nvim_win_set_height(r_terminal_window, 20)
      local current_window = vim.api.nvim_get_current_win()
      vim.api.nvim_set_var("r_last_window", current_window)
      vim.api.nvim_set_current_win(r_terminal_window)
    else
      vim.api.nvim_win_set_height(r_terminal_window, 1)
      local is_ok, last_window = pcall(vim.api.nvim_get_var, "r_last_window")
      if (is_ok) then vim.api.nvim_set_current_win(last_window) end
    end
  end
end
