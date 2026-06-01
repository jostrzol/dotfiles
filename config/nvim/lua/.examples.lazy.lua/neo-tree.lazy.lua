-- Example local configuration that:
-- * adds a file/directory name to hidden items in Neo-tree

if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazyPluginSpec[]
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_by_name = { ".direnv" },
          hide_by_pattern = { "*/.direnv" },
        },
      },
    },
  },
}

