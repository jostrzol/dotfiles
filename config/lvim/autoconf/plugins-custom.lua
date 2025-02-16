lvim.plugins = {
  { "christoomey/vim-tmux-navigator" },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-surround" },
  {
    "nvim-neotest/neotest",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = {
              justMyCode = false,
              console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG", "--quiet" },
            runner = "pytest",
          })
        }
      })
    end
  },
  { "nvim-neotest/nvim-nio" },
  { "mfussenegger/nvim-dap-python" },
  { "nvim-neotest/neotest-python" },
  {
    "mrcjkb/rustaceanvim",
    lazy = false, -- This plugin is already lazy
  },
  {
    "preservim/vim-markdown",
    config = function()
      -- it is very buggy
      vim.g["vim_markdown_folding_disabled"] = 1
    end
  },
  {
    "scalameta/nvim-metals",
    config = function()
      local lvim_lsp = require("lvim.lsp")
      local metals_config = require("metals").bare_config()
      metals_config.on_init = lvim_lsp.common_on_init
      metals_config.on_exit = lvim_lsp.common_on_exit
      metals_config.capabilities = lvim_lsp.common_capabilities()
      metals_config.on_attach = function(client, bufnr)
        lvim_lsp.common_on_attach(client, bufnr)
        require("metals").setup_dap()
      end
      metals_config.settings = {
        superMethodLensesEnabled = true,
        showImplicitArguments = true,
        showInferredType = true,
        showImplicitConversionsAndClasses = true,
        excludedPackages = {},
      }
      metals_config.init_options.statusBarProvider = false
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function() require("metals").initialize_or_attach(metals_config) end,
        group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
      })
    end,
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
            pattern = [[(%f[-.~_a-zA-Z0-9/][%.~]?/[-._a-zA-Z0-9/]+)]],
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
        on_attach = function(buf)
          local ft = vim.api.nvim_get_option_value("filetype", { buf = buf });
          return ft ~= "zig"
        end
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup {
        textobjects = {
          select = {
            enable = true,
            disable = { "zig" },
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
          },
        },
      }
    end
  },
  {
    "bkad/CamelCaseMotion",
    config = function()
      vim.api.nvim_call_function("camelcasemotion#CreateMotionMappings", { "," })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
