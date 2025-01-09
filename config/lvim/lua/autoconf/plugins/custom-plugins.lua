lvim.plugins = {
  { "christoomey/vim-tmux-navigator" },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-surround" },
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
  },
  { "rickhowe/diffchar.vim" },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
    dependencies = { "junegunn/fzf" }
  },
  { "tpope/vim-repeat" },
  {
    "jalvesaq/Nvim-R",
    config = function()
      vim.g["R_assign"] = "3"
      vim.g["R_disable_cmds"] = { "RStart" }
    end,
  },
  {
    "jalvesaq/cmp-nvim-r",
    config = function()
      require("cmp_nvim_r").setup({
        filetypes = { "r", "rmd", "quarto" },
        doc_width = 58
      })
    end,
  },
  { "tpope/vim-abolish" },
  {
    "sontungexpt/url-open",
    event = "VeryLazy",
    cmd = "URLOpenUnderCursor",
    config = function()
      local status_ok, url_open = pcall(require, "url-open")
      if not status_ok then
        return
      end
      url_open.setup({
        open_app = "xdg-open",
        extra_patterns = {
          {
            pattern = [[(%f[-.a-zA-Z0-9/]%.?/[-.a-zA-Z0-9/]+)]],
          },
          -- Matches UNIX file paths
          -- /home/
          -- ./custom-plugins.lua
          -- but not: asd/asd
        }
      })
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
}
