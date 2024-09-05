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
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      -- Only needed if you want to use session lens
      "nvim-telescope/telescope.nvim",
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    opts = {
      suppressed_dirs = { "~/", "~/ws", "~/Downloads", "/" },
      -- log_level = 'debug',
    }
  },
  {
    "klen/nvim-config-local",
    config = function()
      require("config-local").setup({
        config_files = { ".nvim.lua", ".nvimrc", ".exrc" },

        -- Where the plugin keeps files data
        hashfile = vim.fn.stdpath("data") .. "/config-local",
        -- Create autocommands (VimEnter, DirectoryChanged)
        autocommands_create = true,
        -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
        commands_create = true,
        -- Disable plugin messages (Config loaded/ignored)
        silent = false,
        -- Lookup config files in parent directories
        lookup_parents = false,
      })
    end,
  }
}
