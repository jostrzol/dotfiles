---@type LazySpec
return {
  "L3MON4D3/LuaSnip",
  config = function(plugin, opts)
    -- include the default astronvim config that calls the setup call
    require "astronvim.plugins.configs.luasnip"(plugin, opts)

    local path = vim.fn.stdpath "config" .. "/snippets"
    require("luasnip.loaders.from_vscode").lazy_load { paths = { path } }
  end,
  specs = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ln"] = { function() require("luasnip.loaders").edit_snippet_files() end, desc = "Edit Snippets" },
        },
      },
    },
  },
}
