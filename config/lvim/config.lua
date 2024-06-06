-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  { "christoomey/vim-tmux-navigator" },
  -- {
  --   "edkolev/tmuxline.vim",
  --   config = function ()
  --   end
  -- },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-surround" },
  { "qpkorr/vim-bufkill" },
}

lvim.keys.normal_mode["]c"] = "<Cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<CR>"
lvim.keys.normal_mode["[c"] = "<Cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<CR>"
lvim.keys.normal_mode["<Leader><Leader>"] = "<C-6>"
