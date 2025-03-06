---@type LazyPluginSpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>r"] = { "<cmd>Neotree reveal_force_cwd<cr>", desc = "Reveal file" },
          },
        },
      },
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
  },
}
