-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  { "christoomey/vim-tmux-navigator" },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-surround" },
  { "qpkorr/vim-bufkill" },
}

local null_ls = require("null-ls")
null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.mdformat,
  }
})

lvim.keys.normal_mode["]c"] = "<Cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<CR>"
lvim.keys.normal_mode["[c"] = "<Cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<CR>"
lvim.keys.normal_mode["]g"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["[g"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["<M-f>"] = "<Cmd>lua require('lvim.lsp.utils').format()<CR>"
lvim.keys.normal_mode["<Leader><Leader>"] = "<C-6>"


vim.wo.wrap = true
vim.wo.linebreak = true
vim.lsp.set_log_level('debug')

function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

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
