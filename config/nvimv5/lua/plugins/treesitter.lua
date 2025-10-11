-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },

    -- Disable error messages
    ignore_install = {},
    parser_install_dir = nil,
    auto_install = false,
    sync_install = false,
    modules = {},

    -- Extensions
    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = "v",
        node_decremental = "<M-v>",
      },
    },
    textobjects = {
      select = {
        keymaps = {
          ["al"] = "@call.outer",
          ["il"] = "@call.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
    },
  },
  specs = {
    { "windwp/nvim-ts-autotag" },
  },
}
