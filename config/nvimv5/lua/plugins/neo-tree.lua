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
    buffers = {
      -- TODO: this doesn't keep neo-tree from jumping around when switching
      -- buffers. Fix it.
      follow_current_file = {
        -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        enabled = false,
        -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        leave_dirs_open = true,
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { "node_modules", ".venv", ".vscode", ".git", ".claude", ".nlsp-settings" },
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
