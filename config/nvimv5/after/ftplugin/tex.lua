vim.o.textwidth = 80
vim.o.number = false
vim.o.spell = true

---@param env string
local function is_in_env(env)
  local _begin = "begin{" .. env .. "}"
  local _end = "end{" .. env .. "}"
  local pos = vim.api.nvim_win_get_cursor(0)
  local result = vim.fn.searchpair(_begin, "", _end)
  vim.api.nvim_win_set_cursor(0, pos)
  return result ~= 0
end

-- Automatically adds item on enter in itemize and enumerate environments
vim.keymap.set({ "i" }, "<Cr>", function()
  if is_in_env "itemize" or is_in_env "enumerate" then
    return "\r\\item "
  else
    return "\r"
  end
end, { silent = false, noremap = true, expr = true })

-- Automatically adds item on 'o' in itemize and enumerate environments
vim.keymap.set({ "n" }, "o", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1]
  if is_in_env "itemize" or is_in_env "enumerate" then
    vim.api.nvim_buf_set_lines(0, line, line, false, { "\\item " })
  else
    vim.api.nvim_buf_set_lines(0, line, line, false, { "" })
  end
  vim.api.nvim_win_set_cursor(0, { line + 1, pos[2] })
  vim.cmd "normal! =="
  vim.cmd "startinsert!"
end, { silent = false, noremap = true })

-- Automatically adds item on 'O' in itemize and enumerate environments
vim.keymap.set({ "n" }, "O", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1]
  if is_in_env "itemize" or is_in_env "enumerate" then
    vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { "\\item " })
  else
    vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { "" })
  end
  vim.api.nvim_win_set_cursor(0, { line, pos[2] })
  vim.cmd "normal! =="
  vim.cmd "startinsert!"
end, { silent = false, noremap = true })

require("which-key").add {
  {
    "<C-B>",
    function()
      vim.api.nvim_feedkeys("S}", "m", false)
      --
      -- local vstart = vim.fn.getpos "'<"
      -- local vend = vim.fn.getpos "'>"
      -- _G.put { vstart, vend }
      --
      -- local lines = vim.api.nvim_buf_get_lines(0, vstart[2], vend[2] + 1, false)
      -- _G.put(lines)
      --
      -- -- local new_lines = {}
      -- -- if #lines == 1 then
      -- --   local prefix = string.sub(lines[1], 0, vstart[3])
      -- --   local selected = string.sub(lines[1], vstart[3] + 1, vend[3])
      -- --   local suffix = string.sub(lines[1], vend[3] + 1)
      -- --   new_lines = { prefix .. "\\textbf{" .. selected .. "}" .. suffix }
      -- -- else
      -- --   local first_prefix = string.sub(lines[1], 0, vstart[3])
      -- --   local first_selected = string.sub(lines[1], vstart[3] + 1)
      -- --
      -- --   local last_selected = string.sub(lines[#lines], 0, vend[3])
      -- --   local last_suffix = string.sub(lines[#lines], vend[3] + 1)
      -- --
      -- --   new_lines[1] = first_prefix .. "\\textbf{" .. first_selected
      -- --   for i = 2, #lines - 1, 1 do
      -- --     new_lines[i] = lines[i]
      -- --   end
      -- --   new_lines[#lines] = last_selected .. "}" .. last_suffix
      -- -- end
      --
      -- -- vim.api.nvim_buf_set_lines(0, vstart[1], vend[1], false, new_lines)
    end,
    desc = "Make bold",
    mode = "v",
    -- nowait = true,
  },
}
