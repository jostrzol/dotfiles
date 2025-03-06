---@type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  specs = {
    { "windwp/nvim-ts-autotag" },
  },
  opts = {
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
