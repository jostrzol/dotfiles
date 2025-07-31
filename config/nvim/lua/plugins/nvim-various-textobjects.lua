---@type LazyPluginSpec
return {
  "chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",
  opts = {
    keymaps = {
      useDefaults = true,
      disabledDefaults = { "gw" },
    },
  },
}
