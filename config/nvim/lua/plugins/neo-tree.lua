local telescope = require "telescope.builtin"

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
      window = {
        mappings = {
          ["<Leader>fw"] = {
            function(state)
              local node = state.tree:get_node()
              telescope.live_grep { search_dirs = { node.path } }
            end,
            desc = "Find words under node",
          },
          ["<Leader>ff"] = {
            function(state)
              local node = state.tree:get_node()
              telescope.find_files { search_dirs = { node.path } }
            end,
            desc = "Find files under node",
          },
        },
      },
    },
  },
}
