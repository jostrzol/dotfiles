---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  specs = {
    { "windwp/nvim-ts-autotag" },
  },
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = "v",
        node_decremental = "<M-V>",
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
}
