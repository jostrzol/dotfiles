---@type LazyPluginSpec
return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts) require("functions").swap_mapping_deep(opts.mappings, "<Leader>t", "<Leader>T") end,
}
