lvim.plugins = {
  { "christoomey/vim-tmux-navigator" },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-surround" },
  { "qpkorr/vim-bufkill" },
  { "nvim-neotest/neotest" },
  { "nvim-neotest/nvim-nio" },
  { "mfussenegger/nvim-dap-python" },
  { "nvim-neotest/neotest-python" },
  {
    "mrcjkb/rustaceanvim",
    lazy = false, -- This plugin is already lazy
  },
  { "preservim/vim-markdown" },
  {
    "ray-x/lsp_signature.nvim",
    config = function() require("lsp_signature").on_attach() end,
    event = "BufRead"
  },
  {
    "scalameta/nvim-metals",
    config = function() require("conf.plugins.nvim-metals").config() end,
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
      -- Only needed if you want to use session lens
      'nvim-telescope/telescope.nvim',
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    opts = {
      suppressed_dirs = { '~/', '~/ws', '~/Downloads', '/' },
      -- log_level = 'debug',
    }
  },
}
